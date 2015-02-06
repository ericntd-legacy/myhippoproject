package org.example.components;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.cxf.common.util.StringUtils;
import org.example.beans.Review;
import org.hippoecm.hst.component.support.forms.FormField;
import org.hippoecm.hst.component.support.forms.FormMap;
import org.hippoecm.hst.component.support.forms.FormUtils;
import org.hippoecm.hst.content.annotations.Persistable;
import org.hippoecm.hst.content.beans.ObjectBeanManagerException;
import org.hippoecm.hst.content.beans.ObjectBeanPersistenceException;
import org.hippoecm.hst.content.beans.manager.workflow.BaseWorkflowCallbackHandler;
import org.hippoecm.hst.content.beans.manager.workflow.WorkflowPersistenceManager;
import org.hippoecm.hst.content.beans.query.HstQuery;
import org.hippoecm.hst.content.beans.query.exceptions.QueryException;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.hst.content.beans.standard.HippoDocumentBean;
import org.hippoecm.hst.core.component.HstComponentException;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.core.parameters.ParametersInfo;
import org.hippoecm.hst.util.ContentBeanUtils;
import org.onehippo.cms7.essentials.components.EssentialsListComponent;
import org.onehippo.cms7.essentials.components.info.EssentialsDocumentListComponentInfo;
import org.onehippo.repository.documentworkflow.DocumentWorkflow;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Session;
import java.util.Calendar;

/**
 * Created by eric on 5/2/15.
 */
@ParametersInfo(type = EssentialsDocumentListComponentInfo.class)
public class Reviews extends EssentialsListComponent {
    private static final Logger log = LoggerFactory.getLogger(Reviews.class);
    private static final String PROJECT_NAME = "myhippoproject";

    @Override
    public void doBeforeRender(HstRequest request, HstResponse response) {
        log.info("doBeforeRender");
        super.doBeforeRender(request, response);

        // retrieve form data (if any)

        FormMap formMap = new FormMap();
        FormUtils.populate(request, formMap);

        request.setAttribute("errors", formMap.getMessage());
        request.setAttribute("name", getFormFieldValue(formMap, "name"));
        request.setAttribute("email", getFormFieldValue(formMap, "email"));
        request.setAttribute("comment", getFormFieldValue(formMap, "comment"));

        Long rating;
        try {
            rating = Long.parseLong(getFormFieldValue(formMap, "rating"));
        } catch (NumberFormatException e) {
            rating = 0L;
        }
        request.setAttribute("rating", rating);

        request.setAttribute("success", request.getParameter("success"));
    }

    @Override
    protected <T extends EssentialsDocumentListComponentInfo> HstQuery buildQuery(HstRequest request, T paramInfo,
                                                                                  HippoBean scope) {

        HippoDocumentBean subject = request.getRequestContext().getContentBean(HippoDocumentBean.class);

        if (subject == null) {
            log.warn("subject is null");
            return null;
        } else {
            log.info("subject is "+subject);
        }

        HippoBean siteBaseBean = request.getRequestContext().getSiteContentBaseBean();
        HippoBean reviewsFolder = siteBaseBean.getBean("product-reviews");

        if (reviewsFolder == null) {
            log.warn("reviewsFolder is null");
            return null;
        }

        try {
            HstQuery reviewsQuery = ContentBeanUtils.createIncomingBeansQuery(subject, reviewsFolder, 4, Review.class,
                    false);
            return reviewsQuery;
        } catch (QueryException e) {
            log.warn("Failed to create incoming beans query", e);
        }

        return null;

    }

    @Persistable
    @Override
    public void doAction(HstRequest request, HstResponse response) throws HstComponentException {
        log.info("doAction");
        // retrieve form field values
        FormMap formMap = new FormMap(request, new String[] { "name", "email", "comment", "rating" });

        // validate form input
        boolean valid = true;
        for (String fieldName : formMap.getFieldNames()) {
            FormField field = formMap.getField(fieldName);
            if (StringUtils.isEmpty(field.getValue()) || ("rating".equals(fieldName) && "0".equals(field.getValue()))) {
                field.addMessage("Field is required");
                valid = false;
            }
        }

        // if form is invalid, persist form date and do not continue processing
        if (!valid) {
            FormUtils.persistFormMap(request, response, formMap, null);
            return;
        }

        // get the document that is being reviewed
        HippoDocument subject = request.getRequestContext().getContentBean(HippoDocument.class);

        if (subject == null) {
            throw new HstComponentException("No subject to review");
        }

        String subjectUuid = subject.getCanonicalHandleUUID();

        String siteContentBasePath = request.getRequestContext().getSiteContentBasePath();
        Calendar currentDate = Calendar.getInstance();

        String reviewsFolderPath = "/" + siteContentBasePath + "/product-reviews/" + currentDate.get(Calendar.YEAR)
                + "/" + currentDate.get(Calendar.MONTH) + "/" + currentDate.get(Calendar.DAY_OF_MONTH);

        String reviewDocumentName = "review-for-" + subject.getName() + "-" + currentDate.getTimeInMillis();

        WorkflowPersistenceManager wpm = null;

        try {
            Session session = request.getRequestContext().getSession();
            wpm = getWorkflowPersistenceManager(session);

            wpm.setWorkflowCallbackHandler(new BaseWorkflowCallbackHandler<DocumentWorkflow>() {
                public void processWorkflow(DocumentWorkflow wf) throws Exception {
                    wf.requestPublication();
                }
            });

            String reviewDocumentPath = wpm.createAndReturn(reviewsFolderPath, PROJECT_NAME+":review", reviewDocumentName, true);

            Review review = (Review) wpm.getObject(reviewDocumentPath);

            if (review == null) {
                throw new HstComponentException("Failed to add Review");
            }

            review.setDate(currentDate);
            review.setName(formMap.getField("name").getValue());
            review.setEmail(formMap.getField("email").getValue());
            review.setComment(formMap.getField("comment").getValue());

            Long rating;
            try {
                rating = Long.parseLong(formMap.getField("rating").getValue());
            } catch (NumberFormatException e) {
                rating = 0L;
            }
            review.setRating(rating);

            review.setSubjectUuid(subjectUuid);

            wpm.update(review);

            response.setRenderParameter("success", "success");

        } catch (Exception e) {
            log.error("Failed to persist review: {}", e.getMessage(), e);
            if (wpm != null) {
                try {
                    wpm.refresh();
                } catch (ObjectBeanPersistenceException e1) {
                    log.warn("Failed to refresh: ", e1);
                }
            }
        }
    }

    private String getFormFieldValue(FormMap formMap, String fieldName) {
        if (formMap != null && !StringUtils.isEmpty(fieldName)) {
            if (formMap.getFormMap().containsKey(fieldName)) {
                return StringEscapeUtils.escapeHtml(formMap.getField(fieldName).getValue().trim());
            }
        }
        return "";
    }
}
