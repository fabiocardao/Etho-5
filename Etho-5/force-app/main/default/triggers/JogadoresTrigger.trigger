trigger JogadoresTrigger on Jogador__c (before insert, before update) {

    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            JogadoresTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }

    }

    /*if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            JogadoresTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            JogadoresTriggerHandler.afterInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            JogadoresTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }*/
}