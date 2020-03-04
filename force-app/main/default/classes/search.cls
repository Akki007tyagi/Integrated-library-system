public with sharing class search {
   @AuraEnabled(cacheable=true)
    public static List<Item__c> search(String searchKey) {
String key='%'+searchKey+'%';
return [Select id,Name, Name__c, Type__c FROM Item__c where Status__c='Available' AND Name__c like:key limit 5];

    }
}
