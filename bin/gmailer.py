#!/usr/bin/python
# encoding: utf-8

import smtplib, datetime, os, tarfile, getpass
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email import Encoders
from optparse import OptionParser


class Email:
    sender=None
    recipient=None
    
    subject_line="[Gmailer] Automatic backup"
    body="This is an automated backup sent on %s." % str(datetime.date.today())
    attachments=[]
    
    # obviously, do override these properties
    smtp_user=None
    smtp_pass=None
    
    #override these values if you want to use another service
    smtp_server="smtp.gmail.com"
    smtp_port=587
    
    """docstring for ClassName"""
    def __init__(self):
        pass
    
    def construct_message(self):
        msg = MIMEMultipart()

        msg['From'] = self.sender
        msg['To'] = self.recipient
        msg['Subject'] = self.subject_line

        msg.attach(MIMEText(self.body))
        
        for i in self.attachments:
            part = MIMEBase('application', 'octet-stream')
            part.set_payload(open(i, 'rb').read())
            Encoders.encode_base64(part)
            part.add_header('Content-Disposition',
                    'attachment; filename="%s"' % os.path.basename(i))
            msg.attach(part)
        
        return msg.as_string()
        
    def check_all_arguments(self):
        REQUIRED=[self.smtp_user, self.smtp_pass]
        
        if self.sender==None:
            self.sender="%s@gmail.com"%self.smtp_user
            self.recipient=self.sender
        
        for i in REQUIRED:
            if (i==None):
                print "You have not set all the properties required for an email."
                print "Please set smtp_user and smtp_pass and try again."
                return False
        return True
    
    def send(self):
        if (self.check_all_arguments()):
            message=self.construct_message()
            # send the mail
            mailServer = smtplib.SMTP(self.smtp_server, self.smtp_port)
            mailServer.ehlo()
            mailServer.starttls()
            mailServer.ehlo()
            mailServer.login(self.smtp_user, self.smtp_pass)
            mailServer.sendmail(self.sender, self.recipient, message)
            # Should be mailServer.quit(), but that crashes...
            mailServer.close()

def generate_text_from_file(file, msg, indents):
    # generate right amount of indents
    i=0
    while i<indents:
        msg+=" "
        i+=1
    msg+=file+"\n"
    print msg
    """if os.path.isdir(file):
        for k in os.listdir(file):
            msg+=generate_text_from_file(k, msg, indents+1)"""
    return msg

def generate_text(attachments):
    msg=""    
    for i in attachments:
        msg+=generate_text_from_file(i,"", 0)
        
    msg+="\n\n"
        
    msg+="gmailer.py's homepage is http://lenni.info"
    return msg

def main():
    """docstring for main"""
    
    parser = OptionParser()
    parser.add_option("-a", "--archive-file-name", dest="archive_file",
                      help="Name of the archive file attached to the email", metavar="FILE")
    
    parser.add_option("-u", "--user", dest="user",
                      help="SMTP username (or your GMail username)", metavar="USER")
                      
    parser.add_option("-p", "--pass", dest="passwd",
                      help="SMTP password (or your GMail password)", metavar="PASS")
                      
    parser.add_option("-s", "--subject", dest="subject",
                    help="The subject line of the email", metavar="PASS")
    
    (options, attachments) = parser.parse_args()
    
    
    path="/tmp/"
    
    filename="gmailer-backup-%s.tar.bz2"% str(datetime.date.today())
    
    tar = tarfile.open(filename, "w:bz2")

    for name in attachments:
        """tarinfo = tar.gettarinfo(name, "fakeproj-1.0/" + name)
        tarinfo.uid = os.getuid()
        tarinfo.gid = 456
        tarinfo.uname ="lenni"
        tarinfo.gname = "agroup" """
        tar.add(name)
        print "Compressing %s..."% name
    tar.close()
    
    print "Preparing email message..."
    #ensuring the default values
    if options.user==None:
        options.user=raw_input("Please enter your GMail or SMTP username:")
        
    if options.passwd==None:
        options.passwd=getpass.getpass("Please enter your password:")
    
    mail=Email()
    mail.smtp_user=options.user
    mail.smtp_pass=options.passwd
    
    print generate_text(attachments)
    
    #mail.body=
    mail.attachments.append(filename)
    print "Establishing connection to mail server..." 
    mail.send()
    print "Email sent to %s" % mail.recipient
    os.remove(filename)
    

if __name__ == '__main__':
    main()