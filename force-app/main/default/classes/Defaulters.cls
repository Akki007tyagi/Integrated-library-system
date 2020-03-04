public with sharing class Defaulters {

  //Returns list of employees with some items checked out.
    @AuraEnabled(cacheable=true)
    public static List <Employee__c> fetchEmployees() {
        
    
      List<Borrowing__c> bor=[Select id,Employee__r.id,Day_of_Return__c from Borrowing__c ];
      List<Employee__c> emp=new List<Employee__c>();
      for(Borrowing__c b:bor){
      
      Employee__c emp1=[Select ID,Employee_ID__c,Name,Department__c,Email__c,Phone_Number__c from Employee__c where ID =: b.Employee__r.id];
        
      if(!emp.contains(emp1) && b.Day_of_Return__c==null){
        emp.add(emp1);  
      }
    }
     
      
        return emp;
    }


}
