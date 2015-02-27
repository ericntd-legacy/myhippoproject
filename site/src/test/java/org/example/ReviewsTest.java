package org.example;

import org.example.components.Reviews;
import org.hippoecm.hst.content.beans.standard.HippoBean;
import org.hippoecm.hst.content.beans.standard.HippoDocument;
import org.hippoecm.hst.core.component.HstRequest;
import org.hippoecm.hst.core.component.HstResponse;
import org.hippoecm.hst.mock.core.component.MockHstRequest;
import org.hippoecm.hst.mock.core.component.MockHstResponse;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.runners.MockitoJUnitRunner;

import static org.easymock.EasyMock.createMockBuilder;
import static org.easymock.EasyMock.expect;
import static org.easymock.EasyMock.replay;
import static org.junit.Assert.assertSame;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.verify;

/**
 * Created by eric on 27/2/15.
 */
// @RunWith(MockitoJUnitRunner.class)
public class ReviewsTest {
//    @Mock public HstRequest request;
//    @Mock public HstResponse response;
//    @Spy public Reviews component = new Reviews();

    MockHstRequest fakeRequest;
    MockHstResponse fakeResponse;
    Reviews component;

    @Before
    public void setUp() throws Exception {
        fakeRequest = new MockHstRequest();
        fakeResponse = new MockHstResponse();
        component = createMockBuilder(Reviews.class).
                addMockedMethod("getContentBean", HstRequest.class).
                createMock();
    }

//    @Test
//    public void testDocumentOnRequestAfterDoBeforeRender() throws Exception {
//
//        //stub
//        doReturn(new HippoDocument()).when(component).getContentBean(request);
//        //test
//        component.doBeforeRender(request, response);
//        //verify
//        verify(request).setAttribute(anyString(), any(HippoDocument.class));
//    }

    @Test
    public void testDocumentOnRequestAfterDoBeforeRender() throws Exception {

        HippoBean bean = new HippoDocument();

//record the expected behavior
        expect(component.getContentBean(fakeRequest)).andReturn(bean);

//stop recording and switch the mocked Object to replay state.
        replay(component);

        component.doBeforeRender(fakeRequest,fakeResponse);

//verify the specified behavior has been used
        verify(component);

        assertSame(fakeRequest.getAttribute("document"),bean);
    }
}
