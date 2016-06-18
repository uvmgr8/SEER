from os import listdir, chdir

corpus = []

#Function to create a corpus from the Enron dataset
def createCorpus(dirNames):
    data=[]
    newData=[]
    badWords=['Message-ID:','Date:','From:','To:','Subject:','Mime-Version:','Content-Type:','Content-Transfer-Encoding:','X-From:','X-To:','X-cc:','X-bcc:','X-Folder:','X-Origin:','X-FileName:','\n','@','-----Original Message-----','--']
    #Read all the directories for a person
    #We will only read emails sent by the person for now.
    #Since some employees received the mails anyways, we thus avoid redundancy
    for name in dirNames:
        chdir("C:\\Users\\Admin\\Documents\\Enron\\maildir\\%s" %name)
        subfolders = listdir('.')
        sentMails = [n for n, sf in enumerate(subfolders) if "sent" in sf]
        sentMailDir = [subfolders[i] for i in sentMails]
        #Now read all emails that very sent by the person
        for dirs in sentMailDir:
            chdir("C:\\Users\\Admin\\Documents\\Enron\\maildir\\%s\\%s" % (name,dirs))
            mails = listdir('.')
            data.append([" ".join(open(files, 'r').readlines()) for files in mails if "_" in files])

    #Now we clean the data and remove unwanted words
    for subfolder in data:
        for email in subfolder:
            #shorten the parsed data
            if ".nsf" in email:
                emtype = ".nsf"
            elif ".pst" in email:
                emtype = ".pst"
            emailFilter = email[email.find(emtype)+4:]

            #Remove only those words specified in the list above
            for word in badWords:
                if word in emailFilter:
                    emailFilter=emailFilter.replace(word,"")
            newData.append(emailFilter)

    #return the data as corpus
    
    return newData

 
#Direct Current Working Directory to the Enron Dataset. Maildir contains all mails as of latest update.
chdir("C:\\Users\\Admin\\Documents\\Enron\\maildir")

#All the directories inside maildir are names of people i.e. Enron employees
dirNames = [d for d in listdir(".") if "." not in d]

corpus=createCorpus(dirNames)
#print corpus[1]
