public with sharing class UpdateFieldsBatchableMain {
    public UpdateFieldsBatchableMain() {
        /*Map<Schema.SObjectField, Object> fieldsValuesMap1 = new Map<Schema.SObjectField, Object> {
            Account.Name => 'Name',
            Account.BillingState => 'RJ'
        };*/

        /*Map<Schema.SObjectField, Object> fieldsValuesMap = new Map<Schema.SObjectField, Object> {
            Candidato__c.CEPAlterado__c => false,
            Candidato__c.Email__c => 'teste@salesforce.com'
        };*/

        Map<Schema.SObjectField, Object> fieldsValuesMap = new Map<Schema.SObjectField, Object> {
            Jogador__c.Nick__c => 'Fábio',
            Jogador__c.Divida__c => 10000,
            Jogador__c.Velocidade__c => 10,
            Jogador__c.Forca__c => 10,
            Jogador__c.Inteligencia__c => 10
        };

        //String query = 'SELECT Aceite__c, Bairro__c, Celular__c, CEPAlterado__c, Email__c FROM Candidato__c WHERE CEPAlterado__c = true';
        String query = 'SELECT Nick__c, Divida__c, Velocidade__c, Forca__c, Inteligencia__c FROM Jogador__c WHERE Eliminado__c = false';



        Database.executeBatch(new UpdateFieldsBatchable(query, fieldsValuesMap), 1);

        /*for (Schema.SObjectField field : fieldsValuesMap1.keySet()) {
            System.debug('FIELD: ' +  field);
        }

        for (Object value : fieldsValuesMap1.values()) {
            System.debug('VALORES: ' + value);
        }*/
    }
}
