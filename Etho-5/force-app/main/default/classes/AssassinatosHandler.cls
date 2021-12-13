public with sharing class AssassinatosHandler {

    public static void execute() {        
        System.debug('EXECUTE');
        List<Jogador__c> jogadoresNaoEliminados = RoundsSelector.selectJogadoresNaoEliminados();
        System.debug('jogadoresNaoEliminados: ' + jogadoresNaoEliminados);

        RoundsHandler.iniciarRound(jogadoresNaoEliminados.get(0));

        Integer qtdNaoEliminados = jogadoresNaoEliminados.size();
        System.debug('qtdNaoEliminados: ' + qtdNaoEliminados);

        //TODO: ASSASSINO <> ASSASSINADO - OK
        Integer randomAtaque = Utils.generateRandonNumberInclusive(0, qtdNaoEliminados - 1, null);
        System.debug('randomAssassino: ' + randomAtaque);

        Integer randomDefesa = Utils.generateRandonNumberInclusive(0, qtdNaoEliminados - 1, randomAtaque);
        System.debug('randomAssassinado: ' + randomDefesa);

        definirAdversarios(jogadoresNaoEliminados, randomAtaque, randomDefesa);
    }

    @TestVisible
    private static void definirAdversarios(List<Jogador__c> jogadoresNaoEliminados, Integer randomAtaque, Integer randomDefesa) {
        Jogador__c  ataque = jogadoresNaoEliminados.get(randomAtaque);
        System.debug('atacante: ' + ataque);

        Jogador__c defesa = jogadoresNaoEliminados.get(randomDefesa);
        System.debug('defensor: ' + defesa);

        Integer qtdJogadores = jogadoresNaoEliminados.size();
        System.debug('qtdJogadores: ' + qtdJogadores);

        Boolean contraAtaque = false;

        //não é contraAtaque pois é a primeira chamada ao método.
        iniciarAtaque(ataque, defesa, contraAtaque, qtdJogadores);

    }

    @TestVisible
    private static void iniciarAtaque(Jogador__c ataque, Jogador__c defesa, Boolean contraAtaque, Integer qtdJogadores) {
        Integer dadoAtacante = Utils.generateRandonNumberInclusive(1, 20, null);
        System.debug('dadoAtacante: ' + dadoAtacante);

        //TODO: tratar nulo
        Integer dadoAtaque = dadoAtacante + ataque.Forca__c?.intValue();
        System.debug('dadoAtaque: ' + dadoAtaque);

        Integer dadoDefesa = Utils.generateRandonNumberInclusive(1, 10, null) + Utils.generateRandonNumberInclusive(1, 10, null) 
                        + defesa.Inteligencia__c.intValue() + defesa.Velocidade__c.intValue();
        System.debug('dadoDefesa: ' + dadoDefesa);


        System.debug('Jogador__c.Id: ' + ataque.Id);
        System.debug('Jogador__c.Nick__c: ' + ataque.Nick__c);
        System.debug('Jogador__c.Forca__c: ' + ataque.Forca__c);
        System.debug('Jogador__c.Inteligencia__c: ' + ataque.Inteligencia__c);
        System.debug('Jogador__c.Velocidade__c: ' + ataque.Velocidade__c);
        System.debug('Jogador__c.Round__r.Id: ' + ataque.Round__r.Id);


        if (isDadosAtaqueDefesaInformados(dadoAtaque, dadoDefesa)) {
            System.debug('--# DADOS INFORMADOS #--');
           if (isAtaqueMaiorQueDefesa(dadoAtaque, dadoDefesa)) {
                System.debug('--# ATAQUE MAIOR QUE DEFESA #--');
                Assassinato__c jogadorAssassinado = assassinarJogador(ataque, defesa);
                System.debug('jogadorAssassinado: ' + jogadorAssassinado);
    
                if(!hasMoreJogadores(qtdJogadores)) {
                    System.debug('VAMOS ENCERRAR O ROUND');
                    RoundsHandler.encerrarRound(ataque);
                } else {
                    System.debug('--# NÃO ENCERRA O ROUND, HÁ MAIS JOGADORES. #--');
                }

                insert jogadorAssassinado;
            } else {
                System.debug('ENTROU NO ELSE');
                if (isContraAtaque(dadoAtacante, contraAtaque)) {
                    System.debug('--# SEGUUUURAAA O CONTRA ATAQUE #--');
                    iniciarAtaque(defesa, ataque, true, qtdJogadores);
                }
            }
        } else {
            //poderia lançar uma exception de negócio.
            // throw new DadosNaoInformadosException('Dados de combate e/ou Dados de defesa não foram informados')
            System.debug('--# NÃO TEMOS INFORMAÇÕES PARA INICIAR O COMBATE');
        }
    }

    private static Boolean hasMoreJogadores(Integer qtdJogadores) {
        //SE TEMOS APENAS 2 JOGADORES E HOUVE MORTE, NÃO HAVERÁ MAIS CONFRONTO.
        return qtdJogadores > 2;
    }

    @TestVisible
    private static Boolean isContraAtaque(Integer dadoAtacante, Boolean contraAtaque) {
        System.debug('dadoAtacante: ' + dadoAtacante);
        System.debug('contraAtaque: ' + contraAtaque);

        if (dadoAtacante != null && contraAtaque != null) {
            if (dadoAtacante == 1 && !contraAtaque) {
                return true;
            }
            
            return false;
            
        }
        return false;
    }

    @TestVisible
    private static Boolean isAtaqueMaiorQueDefesa(Integer ataque, Integer defesa) {
        System.debug('ataque: ' + ataque);
        System.debug('defesa: ' + defesa);

        return ataque > defesa;
    }

    @TestVisible
    private static Assassinato__c assassinarJogador(Jogador__c ataque, Jogador__c defesa) {
        return new Assassinato__c(
            Assassinados__c = defesa.Id, 
            Assassino__c = ataque.Id,
            DataHora__c = System.now()
        );
    }

    @TestVisible
    private static Boolean isDadosAtaqueDefesaInformados(Integer ataque, Integer defesa) {
        System.debug('--# isDadosAtaqueDefesaInformados #--');
        System.debug('ataque: ' + ataque);
        System.debug('defesa: ' + defesa);

        if (ataque == null || defesa ==  null) {
            return false ;
        } else {
            return true;
        }
    }
}