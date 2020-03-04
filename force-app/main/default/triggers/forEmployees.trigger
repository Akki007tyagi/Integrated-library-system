trigger forEmployees on Employee__c (before insert,before update) {
    Triggerhandler tr=new Triggerhandler();
    if(Trigger.isBefore)
    {
       tr.employeeValidation(Trigger.new);
    }

}