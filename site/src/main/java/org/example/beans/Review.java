package org.example.beans;

import org.hippoecm.hst.content.beans.ContentNodeBinder;
import org.hippoecm.hst.content.beans.ContentNodeBindingException;
import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import java.util.Calendar;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@HippoEssentialsGenerated(internalName = "myhippoproject:review")
@Node(jcrType = "myhippoproject:review")
public class Review extends BaseDocument implements ContentNodeBinder{
	public static final String PROJECT_NAME =  "myhippoproject";
	private static final Logger log = LoggerFactory.getLogger(Review.class);

	private String name;
	private String email;
	private Calendar date;
	private String comment;
	private Long rating;

	public void setName(String name) {
		this.name = name;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setDate(Calendar date) {
		this.date = date;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public void setRating(Long rating) {
		this.rating = rating;
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:name")
	public String getName() {
		return (name==null)? (String) getProperty("myhippoproject:name") :name;
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:email")
	public String getEmail() {
		return (email==null)? (String) getProperty("myhippoproject:email"):email;
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:date")
	public Calendar getDate() {
		return (date==null)? (Calendar) getProperty("myhippoproject:date"):date;
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:rating")
	public Long getRating() {
		return (rating==null)? (Long) getProperty("myhippoproject:rating"):rating;
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:comment")
	public String getComment() {
		return (comment==null)? (String) getProperty("myhippoproject:comment"):comment;
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:subject")
	public HippoBean getSubject() {return getLinkedBean("myhippoproject:subject", HippoBean.class);
	}

	private String subjectUuid;

	public String getSubjectUuid() {
		return subjectUuid;
	}

	public void setSubjectUuid(String subjectUuid) {
		this.subjectUuid = subjectUuid;
	}

	@Override
	public boolean bind(Object content, javax.jcr.Node node) throws ContentNodeBindingException {
		if (content instanceof Review) {
			try {
				Review review = (Review) content;
				node.setProperty(PROJECT_NAME+":name", review.getName());
				node.setProperty(PROJECT_NAME+":email", review.getEmail());
				node.setProperty(PROJECT_NAME+":comment", review.getComment());
				node.setProperty(PROJECT_NAME+":rating", review.getRating());
				node.setProperty(PROJECT_NAME+":date", Calendar.getInstance());

				javax.jcr.Node subjectLinkNode;

				if (node.hasNode(PROJECT_NAME+":subject")) {
					subjectLinkNode = node.getNode(PROJECT_NAME+":subject");
				} else {
					subjectLinkNode = node.addNode(PROJECT_NAME+":subject", "hippo:mirror");
				}
				subjectLinkNode.setProperty("hippo:docbase", review.getSubjectUuid());

			} catch (Exception e) {
				log.error("Unable to bind the content to the JCR Node" + e.getMessage(), e);
				throw new ContentNodeBindingException(e);
			}

		}
		return true;
	}
}
