@isTest
public with sharing class UtilsTest {

    @isTest
    static void testSetValueException() {
        Jogador__c jog = new Jogador__c();
        String errorMessage;
        
        Test.startTest();
        try {
            Utils.setValue(jog, Jogador__c.Name, 'Renato');
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
        Test.stopTest();

        System.assert(errorMessage.contains('Field Name is not editable'), 'O campo name não deveria ser editável');
    }

    @isTest
    static void testSetValue() {
        Jogador__c jogador = new Jogador__c();
        Integer velocidade = 10;
        Integer forca = 30;

        Test.startTest();
        Utils.setValue(jogador, Jogador__c.Velocidade__c, velocidade);
        Utils.setValue(jogador, Jogador__c.Forca__c, forca);  
        
        System.assertEquals(jogador.Velocidade__c, velocidade, 'A velocidade deveria ser ' + velocidade);
        System.assertEquals(jogador.Forca__c, forca, 'A forca deveria ser ' + forca);
    }

    @isTest
    static void testIsMembroStaffVerdadeiro() {
        String tipoDeJogador = 'MembroStaff';
        Jogador__c jogador = new Jogador__c();

        Test.startTest();
        Utils.setValue(jogador, Jogador__c.MembroStaff__c, tipoDeJogador);

        System.assertEquals(
            Utils.isMembroStaff(jogador.MembroStaff__c), true, 'testIsMembroStaffVerdadeiro() deveria ser ' + true
        );
        Test.stopTest();
    }

    @isTest
    static void testIsMembroStaffFalso() {
        String tipoDeJogador = 'JogadorPadrao';
        Jogador__c jogador = new Jogador__c();

        Test.startTest();
        Utils.setValue(jogador, Jogador__c.MembroStaff__c, tipoDeJogador);

        System.assertEquals(
            Utils.isMembroStaff(jogador.MembroStaff__c), false, 'testIsMembroStaffFalso() deveria ser ' + false
        );
        Test.stopTest();
    }

}