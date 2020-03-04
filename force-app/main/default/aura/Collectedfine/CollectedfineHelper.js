({
    fetchFineHelper : function(component, event, helper) {
        
        var action = component.get("c.fetchFines");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.fine", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})