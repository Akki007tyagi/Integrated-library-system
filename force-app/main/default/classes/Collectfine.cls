public with sharing class Collectfine {

    @AuraEnabled(cacheable=true)
    public static Double fetchFines() {
       
    
      List<Borrowing__c> bor=[Select id,Day_of_Return__c,Fine__c from Borrowing__c ];
      Integer v1 = 0;
      Double fine=v1;
      for(Borrowing__c b:bor){
      if( b.Day_of_Return__c!=null){
       fine=fine+b.Fine__c;
      }
    }
     
        return fine;
    }

   
}
