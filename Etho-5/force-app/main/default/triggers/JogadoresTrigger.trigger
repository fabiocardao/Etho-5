trigger JogadoresTrigger on Jogador__c (before insert, before update) {
    
    // Versão 1: MERDA. MUITO MERDA. EXTREMAMENTE MERDA
    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            JogadoresTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}