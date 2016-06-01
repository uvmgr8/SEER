import sys
import imaplib
import getpass
import email
import datetime

def read_emails(M):
    rv, data = M.search(None, "ALL")
    if rv != 'OK':
        print "No messages found!"
        return
    for num in data[0].split():
          rv, data = M.fetch(num, '(RFC822)')
          msg = email.message_from_string(data[0][1])
          print 'Message %s: %s' % (num, msg['Subject'])
          print 'Raw Date:', msg['Date']
          date_tuple = email.utils.parsedate_tz(msg['Date'])
          if date_tuple:
              local_date = datetime.datetime.fromtimestamp(
                  email.utils.mktime_tz(date_tuple))
              print "Local Date:", \
                  local_date.strftime("%a, %d %b %Y %H:%M:%S")


M = imaplib.IMAP4_SSL('imap.gmail.com')
M.login('homeofseer@gmail.com', getpass.getpass())
rv, mailboxes = M.list()
if rv == 'OK':
    print "Mailboxes:"
    print mailboxes
    
rv, data = M.select("INBOX")
if rv == 'OK':
    read_emails(M)
    M.close()
M.logout()


