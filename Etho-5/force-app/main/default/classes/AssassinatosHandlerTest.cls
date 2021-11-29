@isTest
public with sharing class AssassinatosHandlerTest {
    
    @isTest
    static void isAtaqueMaiorQueDefesaTest() {
        Integer ataqueMaior = 10;
        Integer defesaMenor = 5;
        Integer ataqueMenor = 10;
        Integer defesaMaior = 20;
        Integer ataqueNull;
        Integer defesaNull;
        
        Test.startTest();
        Boolean retornoAtaqueMaiorQueDefesa = AssassinatosHandler.isAtaqueMaiorQueDefesa(ataqueMaior, defesaMenor);
        Boolean retornoAtaqueMenorQueDefesa = AssassinatosHandler.isAtaqueMaiorQueDefesa(ataqueMenor, defesaMaior);
        Boolean retornoNull = AssassinatosHandler.isDadosAtaqueDefesaInformados(ataqueNull, defesaNull);
        Test.stopTest();

        System.debug('Retorno ataque maior que defesa: ' + retornoAtaqueMaiorQueDefesa);
        System.debug('Retorno ataque menor que defesa: ' + retornoAtaqueMenorQueDefesa);
        System.debug('Retorno null: ' + retornoNull);

        System.assertEquals(retornoAtaqueMaiorQueDefesa, true);
        System.assertEquals(retornoAtaqueMenorQueDefesa, false);
    }

    @isTest
    static void isContraAtaqueTest() {
        //           1             &&  !false
        //return dadoAtacante == 1 && !contraAtaque;
        
        //será contra ataque.
        Boolean contraAtaqueFalso = false;
        Integer dadoAtacanteIgualA1 = 1;

        Boolean contraAtaqueVerdadeiro = true;
        Integer dadoAtacanteMaiorQue1 = 2;

        Test.startTest();
        Boolean naoEhContraAtaque = AssassinatosHandler.isContraAtaque(dadoAtacanteMaiorQue1, contraAtaqueVerdadeiro);
        Boolean ehContraAtaque = AssassinatosHandler.isContraAtaque(dadoAtacanteIgualA1, contraAtaqueFalso);
        Boolean dadosNulos = AssassinatosHandler.isContraAtaque(null, null);
        Test.stopTest();

        System.assertEquals(false, naoEhContraAtaque, 'Não é contra ataque, algo deu errado. naoEhContraAtaque ==> ' + naoEhContraAtaque);
        System.assertEquals(true, ehContraAtaque, 'Algo deu errado no contra ataque.  ehContraAtaque ==> ' + ehContraAtaque);

        //lançar uma exceção nesse caso para informar a ausência dos dados??
        System.assertEquals(false, dadosNulos, 'dadosNulos ==> ' + dadosNulos);
    }

    @isTest
    static void assassinarJogadorTest() {
        Jogador__c atacante = new Jogador__c(Id = 'a015f00000DZ0JbAAL', Forca__c = 20);
        Jogador__c defensor = new Jogador__c(Id = 'a015f00000DZ0JgAAL', Velocidade__c = 10, Inteligencia__c = 10);

        List<Jogador__c> jogadores = new List<Jogador__c>();
        jogadores.add(atacante);
        jogadores.add(defensor);

        Assassinato__c jogadorAssassinado = new Assassinato__c(
            Assassinados__c = defensor.Id, 
            Assassino__c = atacante.Id,
            DataHora__c = System.now()
        );

        insert jogadorAssassinado;

        Test.startTest();
        Assassinato__c jogadorQueMorreu = AssassinatosHandler.assassinarJogador(atacante, defensor);
        Test.stopTest();

        System.assertEquals(jogadorAssassinado.Assassinados__c, jogadorQueMorreu.Assassinados__c, 'Jogador assassinado e o Jogador que morreu são diferentes.'
                          + ' jogadorAssassinado: ' + JSON.serialize(jogadorAssassinado.Assassinados__c)
                          + ' jogadorQueMorreu: ' + JSON.serialize(jogadorQueMorreu.Assassinados__c));
    }

    @isTest
    static void isDadosAtaqueDefesaInformadosTest() {
        Integer ataque = 20;
        Integer defesa = 10;

        Test.startTest();
        Boolean dadosInformados = AssassinatosHandler.isDadosAtaqueDefesaInformados(ataque, defesa);
        Boolean dadosNulos = AssassinatosHandler.isDadosAtaqueDefesaInformados(null, null);
        Test.stopTest();

        System.assertEquals(true, dadosInformados, 'Os dados de ataque/defesa não foram informados. ' + dadosInformados);
        System.assertEquals(false, dadosNulos, 'Os dados de ataque/defesa não foram informados. ' + dadosNulos);
    }

    @isTest
    static void iniciarContraAtaqueTest() {
        Jogador__c atacante = new Jogador__c(Id = 'a015f00000DZ0JbAAL', Forca__c = 20);
        Jogador__c defensor = new Jogador__c(Id = 'a015f00000DZ0JgAAL', Velocidade__c = 10, Inteligencia__c = 10);

        Boolean contraAtaqueVerdadeiro = true;
        Boolean contraAtaqueFalso = false;

        Test.startTest();
        AssassinatosHandler.iniciarAtaque(atacante, defensor, contraAtaqueVerdadeiro);
        AssassinatosHandler.iniciarAtaque(atacante, defensor, contraAtaqueFalso);
        Test.stopTest();
    }

    @isTest
    static void iniciarAtaque() {
        
    }
}