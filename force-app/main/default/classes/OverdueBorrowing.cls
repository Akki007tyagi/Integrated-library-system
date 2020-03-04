public with sharing class OverdueBorrowing {
    @AuraEnabled(cacheable=true)
    public static List <Borrowing__c> fetchBorrowings() {
        //Qyery 10 accounts
    
      List<Borrowing__c> bor=[Select id,Name,Item_Id__r.id,Employee__r.Name, Item_Id__r.Name__c,	Due_Date__c,Issued_Date__c,Day_of_Return__c from Borrowing__c ];
      List<Borrowing__c> emp=new List<Borrowing__c>();
      for(Borrowing__c b:bor){
      
      if( date.today()>=b.Due_Date__c && b.Day_of_Return__c==null){
        emp.add(b);  
      }
    }
     
        //return list of accounts
        return emp;
    }
}
