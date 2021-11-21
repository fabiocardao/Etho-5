public without sharing class JogadoresTriggerHandler {
    public static void beforeUpdate(List<Jogador__c> records, Map<Id, Jogador__c> oldMap) {
        for (Jogador__c jogador : Trigger.new) {
            Jogador__c jogadorOld = Trigger.oldMap.get(jogador.Id);

            if (!jogadorOld.Eliminado__c && jogador.Eliminado__c) {
                jogador.DataMorte__c = System.now();
            }
        }
    }
}
