public with sharing class AssassinatosTriggerHandler {
    
    @TestVisible
    public static void afterInsert(List<Assassinato__c> jogadoresAssassinados) {
        List<Jogador__c> jogadores = new List<Jogador__c>();

        for (Assassinato__c jogadorAssassinado : jogadoresAssassinados) {
            jogadores.add(afterInsert(jogadorAssassinado));
        }
        update(jogadores);
    }

    private static Jogador__c afterInsert(Assassinato__c jogadorAssassinado) {
        Jogador__c jogador = new Jogador__c();
        jogador.Eliminado__c = true;
        jogador.Morreu__c = true;
        jogador.DataMorte__c = jogadorAssassinado.DataHora__c;
        jogador.Id = jogadorAssassinado.Assassinados__c;

        return jogador;
    }

}