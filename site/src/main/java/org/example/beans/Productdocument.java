package org.example.beans;

import org.onehippo.cms7.essentials.dashboard.annotations.HippoEssentialsGenerated;
import org.hippoecm.hst.content.beans.Node;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.hst.content.beans.standard.HippoHtml;

import java.text.DecimalFormat;
import java.util.List;
import org.hippoecm.hst.content.beans.standard.HippoGalleryImageSet;
import org.example.beans.Imageset;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.NodeIterator;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.query.Query;
import javax.jcr.query.QueryManager;
import javax.jcr.query.QueryResult;

@HippoEssentialsGenerated(internalName = "myhippoproject:productdocument")
@Node(jcrType = "myhippoproject:productdocument")
public class Productdocument extends BaseDocument {
	private Logger log = LoggerFactory.getLogger(this.getClass());

	@HippoEssentialsGenerated(internalName = "myhippoproject:title")
	public String getTitle() {
		return getProperty("myhippoproject:title");
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:price")
	public Double getPrice() {
		return getProperty("myhippoproject:price");
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:introduction")
	public String getIntroduction() {
		return getProperty("myhippoproject:introduction");
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:description")
	public HippoHtml getDescription() {
		return getHippoHtml("myhippoproject:description");
	}

	@HippoEssentialsGenerated(internalName = "myhippoproject:images")
	public List<Imageset> getImages() {
		return getLinkedBeans("myhippoproject:images", Imageset.class);
	}

	public Double getAverageRating() {
		log.info("getAverageRating");
		double averageRating = 0.0;
		try {
			Session session = getNode().getSession();
			QueryManager queryManager = session.getWorkspace().getQueryManager();
			String language = Query.XPATH;
			String expression = "//element(*,myhippoproject:averagerating)[@myhippoproject:subject='" + this.getCanonicalHandleUUID()
					+ "']";
			Query query = queryManager.createQuery(expression, language);
			QueryResult result = query.execute();
			NodeIterator nodes = result.getNodes();
			if (nodes.hasNext()) {
				javax.jcr.Node ratingNode = nodes.nextNode();
				averageRating = ratingNode.getProperty("myhippoproject:rating").getDouble();
			}
		} catch (RepositoryException e) {
			log.error("Failed to retrieve average rating for product document {}", getCanonicalHandleUUID(), e);
		}
		DecimalFormat oneDecimal = new DecimalFormat("#.#");
		return new Double(oneDecimal.format(averageRating));
	}
}
