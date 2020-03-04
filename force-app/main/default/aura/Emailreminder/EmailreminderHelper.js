({
    SendEmail : function(component) {
            
           var action=component.get("c.processEmail");
           action.setParams({
            
           })
           action.setCallback(this,function(e){
               if(e.getState()=='SUCCESS'){
                   var result=e.getReturnValue();
                   if(result=='Success'){
                       alert('Email Send Successfully!');
                   }
                   else{
                       alert(result);
                   }
               }
               else{
                   alert(JSON.stringify(e.getError()));
               }
           });
           $A.enqueueAction(action);
    }
       
       
    })