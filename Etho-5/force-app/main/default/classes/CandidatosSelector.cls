public with sharing class CandidatosSelector {
    public static String getQueryLocatorCEPBatchable() {
        System.debug('ENTROU NO SELECTOR');
        return 'SELECT Id, Name, CEPAlterado__c FROM Candidato__c WHERE CEPAlterado__c = true ORDER BY Name ASC';
    }
}
