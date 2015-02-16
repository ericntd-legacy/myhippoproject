package org.example.modules;

import org.apache.cxf.common.util.StringUtils;
import org.hippoecm.repository.api.HippoNode;
import org.onehippo.cms7.services.HippoServiceRegistry;
import org.onehippo.cms7.services.eventbus.HippoEventBus;
import org.onehippo.cms7.services.eventbus.Subscribe;
import org.onehippo.repository.events.HippoWorkflowEvent;
import org.onehippo.repository.modules.DaemonModule;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.Node;
import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
/**
 * Created by eric on 5/2/15.
 */
public class RatingsModule implements DaemonModule {
    private static final Logger log = LoggerFactory.getLogger(RatingsModule.class);

    private Session session;

    @Override
    public void initialize(Session session) throws RepositoryException {
        log.info("initialize");
        this.session = session;
        HippoServiceRegistry.registerService(this, HippoEventBus.class);
    }

    @Override
    public void shutdown() {
        log.info("shutdown");
        HippoServiceRegistry.unregisterService(this, HippoEventBus.class);
    }

    @Subscribe
    public void handleEvent(final HippoWorkflowEvent event) {
        log.info("handleEvent - "+ event.interaction());
        if (event.success()
                && ("default:handle:publish".equals(event.interaction())
                || "default:handle:depublish".equals(event.interaction()) || "default:handle:acceptRequest"
                .equals(event.interaction()))) {
            try {
                final HippoNode handle = (HippoNode) session.getNodeByIdentifier(event.subjectId());
                Node variant = handle.getNode(handle.getName());
                if (variant.isNodeType("myhippoproject:review")) {
                    String subjectUuid = variant.getNode("myhippoproject:subject").getProperty("hippo:docbase")
                            .getString();
                    calculateAndstoreAverageRating(subjectUuid);
                    Mailer.sendEmail();
                }
            } catch (RepositoryException e) {
                log.error("Failed to process workflow event on {}", event.subjectId(), e);
            }

        }
    }

    private double getAverageRating(String subjectUuid) throws RepositoryException {
        log.info("getAverageRating");
        double averageRating = 0.0;
        QueryManager queryManager = session.getWorkspace().getQueryManager();
        String language = Query.XPATH;
        String expression = "//element(*,myhippoproject:review)[myhippoproject:subject/@hippo:docbase='" + subjectUuid
                + "' and @hippo:availability='live']";
        Query query = queryManager.createQuery(expression, language);
        QueryResult result = query.execute();
        int numberOfReviews = 0;
        Long cumulativeRating = 0L;
        NodeIterator nodeIter = result.getNodes();
        while (nodeIter.hasNext()) {
            javax.jcr.Node node = nodeIter.nextNode();
            numberOfReviews++;
            Long rating = node.getProperty("myhippoproject:rating").getLong();
            cumulativeRating += rating;
        }
        averageRating = cumulativeRating.doubleValue() / (double) numberOfReviews;
        return averageRating;
    }

    private Node getRatingsFolderNode(String subjectUuid) throws RepositoryException {
        log.info("getRatingsFolderNode");
        Node ratingsFolderNode = session.getRootNode();
        StringBuilder builder = new StringBuilder();
        builder.append("/myhippoproject:ratings/");
        builder.append(subjectUuid.charAt(0));
        builder.append("/");
        builder.append(subjectUuid.charAt(1));
        builder.append("/");
        builder.append(subjectUuid.charAt(2));
        String ratingFolderPath = builder.toString();
        String[] nodeNames = ratingFolderPath.split("/");
        for (String nodeName : nodeNames) {
            if (!StringUtils.isEmpty(nodeName)) {
                if (!ratingsFolderNode.hasNode(nodeName)) {
                    ratingsFolderNode = ratingsFolderNode.addNode(nodeName);
                } else {
                    ratingsFolderNode = ratingsFolderNode.getNode(nodeName);
                }
            }
        }
        return ratingsFolderNode;
    }

    private void calculateAndstoreAverageRating(String subjectUuid) throws RepositoryException {
        log.info("calculateAndstoreAverageRating");
        double averageRating = getAverageRating(subjectUuid);
        Node ratingsNode = getRatingsFolderNode(subjectUuid);
        if (!ratingsNode.hasNode(subjectUuid)) {
            ratingsNode.addNode(subjectUuid, "myhippoproject:averagerating");
        }
        Node ratingNode = ratingsNode.getNode(subjectUuid);
        ratingNode.setProperty("myhippoproject:subject", subjectUuid);
        ratingNode.setProperty("myhippoproject:rating", averageRating);
        session.save();
    }
}
