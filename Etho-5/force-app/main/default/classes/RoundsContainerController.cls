public with sharing class RoundsContainerController {
    @AuraEnabled(cacheable = true)
    public static List<Round__c> getRoundsJogadores(){
        try {
            return RoundsSelector.selectAllRoundsWithJogadores();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Round__c> getRoundsEmAndamento(){
        try {
            return RoundsSelector.selectRoundsEmAndamento();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
