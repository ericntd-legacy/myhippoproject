package org.example.modules;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

/**
 * Created by eric on 16/2/15.
 */
public class Mailer {
    private static final Logger l = LoggerFactory.getLogger(Mailer.class);

    public static void sendEmail() {
        l.info("sendEmail");
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getDefaultInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("eric.nguyen@goldenequator.com", "lehuyen@1");
            }
        });

        String msgBody = "A product review has been published";

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("eric.nguyen@goldenequator.com", "Hippo CMS admin"));
            msg.addRecipient(Message.RecipientType.TO,
                    new InternetAddress("eric.nguyen@goldenequator.com", "Eric"));
            msg.setSubject("A product review has been published");
            msg.setText(msgBody);
            Transport.send(msg);

        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
}
