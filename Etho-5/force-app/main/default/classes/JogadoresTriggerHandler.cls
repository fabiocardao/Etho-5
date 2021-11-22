public without sharing class JogadoresTriggerHandler {
    public static void beforeUpdate(List<Jogador__c> records, Map<Id, Jogador__c> oldMap) {
        for (Jogador__c jogador : records) {
            beforeUpdate(jogador, oldMap.get(jogador.Id));
        }
    }

    private static void beforeUpdate(Jogador__c record, Jogador__c recordOld) {
        handleEliminacaoMorte(record, recordOld);
    }

    private static Boolean isChanged(Jogador__c record, Jogador__c recordToCompare, Schema.SObjectField fieldToEvaluate) {
        return isChanged(record.get(fieldToEvaluate), recordToCompare.get(fieldToEvaluate));
    }

    private static Boolean isChanged(Object value, Object valueToCompare) {
        return value != valueToCompare;
    }

    private static void setValue(Jogador__c record, Schema.SObjectField field, Object value) {
        record.put(field, value);
    }

    private static void handleEliminacaoMorte(Jogador__c record, Jogador__c recordOld) {
        if (foiEliminado(record, recordOld) || morreu(record, recordOld)) {
            if (ehJogadorPadrao(record, recordOld)) {
                if (foiEliminado(record, recordOld)) {
                    setValue(record, Jogador__c.DataMorte__c, System.now());
                    setValue(record, Jogador__c.Morreu__c, true);
                }
            } else if (morreu(record, recordOld)) {
                    setValue(record, Jogador__c.DataMorte__c, System.now());
                    setValue(record, Jogador__c.Morreu__c, true);
            }
        }
    }

    private static Boolean ehJogadorPadrao(Jogador__c record, Jogador__c recordOld) {
        return true;
    }

    private static Boolean foiEliminado(Jogador__c record, Jogador__c recordOld) {
        return true;
    }

    private static Boolean morreu(Jogador__c record, Jogador__c recordOld) {
        return true;
    }
}