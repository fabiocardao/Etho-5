@isTest
public with sharing class RoundsSelectorTest {

    @TestSetup
    static void setup(){
        Round__c round = new Round__c();
        insert round;
    }

    @isTest
    static void test1() {
        Map<Id, Round__c> roundsMap = new Map<Id, Round__c>([SELECT Id FROM Round__c]);
        System.debug('Limits BEFORE: ' + Limits.getQueries());

        Test.startTest();
        List<Round__c> rounds = RoundsSelector.selectByRoundsIdsWithJogadores(roundsMap.keySet());
        System.debug('Limits INSIDE: ' + Limits.getQueries());
        Test.stopTest();

        System.debug('Limits AFTER: ' + Limits.getQueries());

        System.assertEquals(roundsMap.size(), rounds.size());
    }

    @isTest
    static void test2() {
        List<Round__c> rounds = [SELECT Id FROM Round__c];
        Id roundId = rounds.get(0).Id;
        Id roundId2 = rounds.get(1).Id;
        Set<Id> ids = new Set<Id>{roundId, roundId2};
        Jogador__c jogador1 = new Jogador__c(Round__c = roundId, Eliminado__c = true);
        Jogador__c jogador2 = new Jogador__c(Round__c = roundId, Eliminado__c = false);
        Jogador__c jogador3 = new Jogador__c(Round__c = roundId2, Eliminado__c = true);
        List<Jogador__c> jogadores = new List<Jogador__c>{jogador1, jogador2, jogador3};
        insert jogadores;

        Test.startTest();
        List<Round__c> roundsAux = RoundsSelector.selectByRoundsIdsWithJogadores(ids);
        Test.stopTest();

        for (Round__c round : roundsAux) {
            if (round.Id.equals(roundId2)) {
                System.assertEquals(1, round.Jogadores__r.size(), 'Só deveria ter 1 jogador no round 2.');
            }
            for (Jogador__c jogador : round.Jogadores__r) {
                if (round.Id.equals(roundId)) {
                    System.assertNotEquals(jogador.Id, jogador2.Id, 'Jogador 2 não deveria ter retornado nessa query.');
                } else if (round.Id.equals(roundId2)) {
                    System.assertEquals(jogador.Id, jogador3.Id, 'Brotou algum jogador que não era o 3, deu alguma merda.');
                }
            }
        }
    }
}