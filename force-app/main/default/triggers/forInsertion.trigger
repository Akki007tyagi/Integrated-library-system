trigger forInsertion on Borrowing__c (before insert, before update,after insert,after update) {
    Triggerhandler tr=new Triggerhandler();
    if(Trigger.isBefore)
    {
        if(Trigger.IsInsert)
        {
            tr.validationBeforeInsertBorrowing(Trigger.new);
            tr.checkItemStatus(Trigger.new);
        }
        else if(Trigger.IsUpdate)
        {
            tr.returndateValidation(Trigger.new);
            tr.checkItemStatusUpdate(trigger.new,trigger.oldMap);
        }
    }
    else if(Trigger.isAfter)
    {
        if(Trigger.IsInsert)
        {
            tr.availability(Trigger.new,0);
        }
        else if(Trigger.IsUpdate)
        {
            
            tr.returnDateUpdate(trigger.new,trigger.oldMap);
        
        }
    }


    
    
}