@isTest
public without sharing class AssassinatosTriggerHandlerTest {
    
    @isTest
    public static void afterInsertTest() {
        Jogador__c assassino = new Jogador__c(Id = 'a015f00000DZ0JbAAL');
        Jogador__c assassinado = new Jogador__c(Id = 'a015f00000DZ0JgAAL');

        Assassinato__c jogadorAssassinado = new Assassinato__c(
            Assassinados__c = assassinado.Id
          , Assassino__c = assassino.Id
          , DataHora__c = System.now()
        );

        List<Assassinato__c> jogadoresAssassinados = new List<Assassinato__c>();
        jogadoresAssassinados.add(jogadorAssassinado);

        Test.startTest();
        AssassinatosTriggerHandler.afterInsert(jogadoresAssassinados);
        Test.stopTest();
    }

}