//Validate Issued date, fine and Day of return & Set due date to 5 days after the issued date. 
public with sharing class Triggerhandler {
	private static final Integer v1 = 5;
    public void validationBeforeInsertBorrowing(List<Borrowing__c> borr) {

        for(Borrowing__c b:borr){ 
            if(b.Issued_Date__c!=null && b.Issued_Date__c==date.today() ){               
                b.Due_Date__c=b.Issued_Date__c+v1;             
                 }
            else{
                 b.Issued_Date__c.addError(' Issued date should be today\'s date only. ');  
                 }

            if(b.Day_of_Return__c!=null){               
                b.Day_of_Return__c.addError('Cannot return item while borrowing ! ');           
                 }

            if(b.Fine__c==0){               
            } 
            else if(b.Fine__c==null){
              b.Fine__c=0;
            } 
            else{
              b.Fine__c.addError('No initial fine should be there.');    
            }   

        }
    }
//Return date validation and Calculating fine. 
        public void returndateValidation(List<Borrowing__c> borr) {

           
            for(Borrowing__c b:borr){
                if(b.Day_of_Return__c>=b.Issued_Date__c){   
                    if(b.Day_of_Return__c>b.Due_Date__c){
                        
                      Integer days = b.Due_Date__c.daysBetween(b.Day_of_Return__c);
                      b.Fine__c=days*10;

                    }   
                    else{
                        b.Fine__c=0; 
                    }         
                               
                     }

                     else if(b.Day_of_Return__c==null){

                     }
                     else{
                        b.Day_of_Return__c.addError('Return date can not be before issued date');
                     }
    
            }
      

}

//To checkout items. 
 public void returnDateUpdate(List<Borrowing__c> newdata,Map<id, Borrowing__c> olddata) {

           
            for(Borrowing__c b:newdata){
              if(olddata.get(b.id).Day_of_Return__c==null && b.Day_of_Return__c!=null){
                availability(newdata,1);

              }
              
    
            }
      

}



public void availability(List<Borrowing__c> borr,Integer flag) {
        

    for(Borrowing__c b:borr){
        
        Borrowing__c obj=[Select id,Item_Id__r.id,Item_Id__r.Units_borrowed__c,Day_of_Return__c from Borrowing__c where id=:b.id ];
        Item__c obj1=[Select id,Units_borrowed__c,Status__c from Item__c where id=:obj.Item_Id__r.id];
          if(flag==0){
          //increase
              
              if(obj1.Units_borrowed__c<v1){   
               obj1.Units_borrowed__c=obj1.Units_borrowed__c+1;   
             //system.debug('checkid'+obj1.id);             
              }
              if(obj1.Units_borrowed__c==v1){
                obj1.Status__c ='Not Available';
              }

           }
         else if(flag==1){
             //decrease
              if(obj1.Status__c!='Available'){
                obj1.Status__c ='Available';
              }
              if(obj1.Units_borrowed__c<=v1){      
                obj1.Units_borrowed__c=obj1.Units_borrowed__c-1;   
            //system.debug('checkid'+obj1.id); 
            }    
            
      }
        
     update(obj1);    

    }
}

//Checking employee id Size.
public void employeeValidation(List<Employee__c> emp){

  for(Employee__c e:emp){
      if(e.Employee_ID__c<10000 ||  e.Employee_ID__c>99999){
        e.Employee_ID__c.addError('Employee id should be of size 5:'); 

      }
  }

}

//Check the status of the item before inserting record.
public void checkItemStatus(List<Borrowing__c> borrowing ){
  
  
  
  for(Borrowing__c bor:borrowing){
   // Borrowing__c b=[Select Id,Item_Id__r.Id from Borrowing__c where Id =:bor.Id];
    Item__c item=[Select Id,Status__c from Item__c where id =:bor.Item_Id__c];
    
    if(item.Status__c!='Available'){
       bor.Item_Id__c.addError('Item is not available. Feel free to borrow other items.');
    }
  }

}


//Disable updation of item on borrowing.  
public void checkItemStatusUpdate(List<Borrowing__c> newvalues,Map<id, Borrowing__c> oldvalues){

  for(Borrowing__c bor:newvalues){
    
     Item__c item=[Select Id,Status__c from Item__c where id =:bor.Item_Id__c];
     
     if(oldvalues.get(bor.id).Item_Id__c!=bor.Item_Id__c ){
     
        bor.Item_Id__c.addError('Error: Cannot change the item after borrowing.');
     
     }
     
   }
 

}

}