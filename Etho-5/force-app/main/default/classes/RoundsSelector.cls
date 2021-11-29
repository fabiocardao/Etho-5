public without sharing class RoundsSelector {
   
    public static List<Round__c> selectByRoundsIdsWithJogadores(Set<Id> ids) {
        return [
            SELECT Id, TotalJogadoresEliminados__c, PremioTotal__c,
                   (
                       SELECT Id, ValorPagar__c, RecordTypeId, RecordType.DeveloperName, Candidato__r.Email__c
                       FROM Jogadores__r
                       WHERE Eliminado__c = true
                   )
            FROM Round__c 
            WHERE Id IN :ids
        ];
    }

    public static List<Jogador__c> selectJogadoresNaoEliminados() {
        return [
            SELECT Id, Nick__c, Forca__c, Inteligencia__c, Velocidade__c
            FROM Jogador__c
            WHERE Eliminado__c = false
            AND Round__r.Status__c = 'Em Andamento'
        ];
    }
}