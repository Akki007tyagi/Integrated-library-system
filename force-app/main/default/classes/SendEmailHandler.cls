public with sharing class SendEmailHandler {
    @AuraEnabled
    public static string processEmail(){
        String sMessage='';
        try{
            List<Borrowing__c> bor=[Select id,Name,Item_Id__r.id,Employee__r.Name, Item_Id__r.Name__c,	Due_Date__c,Issued_Date__c,Day_of_Return__c from Borrowing__c ];
           
            List<Employee__c> emp=new List<Employee__c>();
            for(Borrowing__c b:bor){    
                Employee__c emp1=[Select ID,Employee_ID__c,Name,Department__c,Email__c,Phone_Number__c from Employee__c where ID =: b.Employee__r.id];     
                if(!emp.contains(emp1) && b.Day_of_Return__c==null && b.Due_Date__c<=date.today()){
                  emp.add(emp1);  
                }
            }

            List< Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            String[] toAddresses = new String[emp.size()];

            for(Employee__c e:emp){

                if(e.Email__c!=null && e.Email__c.trim()!=''){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                     String s=e.Email__c;
                    //toAddresses.add(e.Email__c);
                    mail.setToAddresses(new String[] {s});
                    mail.setSubject('Over Due reminder');
                    mail.setHtmlBody('REMINDER: You have items that are needed to be returned to avoid fines! Please return as soon as possible.');
                    mails.add(mail);
                   
                }
            }
            Messaging.SendEmailResult [] results = Messaging.sendEmail(mails);
            sMessage='Success:Reminder sent !';
        }
        catch(Exception ex){
            sMessage=ex.getLineNumber()+'\n'+ex.getCause()+'\n'+ex.getMessage()+'\n'+ex.getStackTraceString();
        }
        return sMessage;
    }
}
