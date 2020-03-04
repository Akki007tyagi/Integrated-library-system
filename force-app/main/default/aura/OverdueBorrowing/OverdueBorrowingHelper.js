({
    fetchBorHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Borrowing Id', fieldName: 'Name', type: 'Text'},
                {label: 'Item Name', fieldName: 'ItemName', type: 'Lookup'},
                {label: 'Employee Name', fieldName: 'EmployeeName', type: 'Lookup'},
                {label: 'Issued Date', fieldName: 'Issued_Date__c', type: 'Date '},
                {label: 'Due Date', fieldName: 'Due_Date__c', type: 'Date '}

            ]);
        var action = component.get("c.fetchBorrowings");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows = response.getReturnValue();
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    if(row.Item_Id__c){
                      row.ItemName=row.Item_Id__r.Name__c;

                    }
                    if(row.Employee__c){
                        row.EmployeeName=row.Employee__r.Name;
  
                      }

                }
                component.set("v.borList",rows);
            }
        });
        $A.enqueueAction(action);
    }
})