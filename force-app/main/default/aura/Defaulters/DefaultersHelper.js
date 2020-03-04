({
    fetchAccHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Employee ID', fieldName: 'Employee_ID__c', type: 'number'},
                {label: 'Employee Name', fieldName: 'Name', type: 'text'},
                {label: 'Department', fieldName: 'Department__c', type: 'text'},
                {label: 'Email', fieldName: 'Email__c', type: 'Email '},
                {label: 'Phone Number', fieldName: 'Phone_Number__c', type: 'Phone '}

            ]);
        var action = component.get("c.fetchEmployees");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.empList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})