public with sharing class AssassinatosHandler {

    static final Integer EH_CONTRA_ATAQUE                       = 1;
    static final Integer NAO_EH_CONTRA_ATAQUE                   = 2;
    static final Integer FALHA_ENTRADA_PARAMETROS_CONTRA_ATAQUE = 3;

    public static void execute() {        
        List<Jogador__c> jogadoresNaoEliminados = RoundsSelector.selectJogadoresNaoEliminados();
        System.debug('jogadoresNaoEliminados: ' + jogadoresNaoEliminados);

        Integer qtdNaoEliminados = jogadoresNaoEliminados.size();
        System.debug('qtdNaoEliminados: ' + qtdNaoEliminados);

        //TODO: ASSASSINO <> ASSASSINADO - OK
        Integer randomAssassino = Utils.generateRandonNumberInclusive(0, qtdNaoEliminados - 1, null);
        System.debug('randomAssassino: ' + randomAssassino);

        Integer randomAssassinado = Utils.generateRandonNumberInclusive(0, qtdNaoEliminados - 1, randomAssassino);
        System.debug('randomAssassinado: ' + randomAssassinado);

        Jogador__c  atacante = jogadoresNaoEliminados.get(randomAssassino);
        System.debug('atacante: ' + atacante);

        Jogador__c defensor = jogadoresNaoEliminados.get(randomAssassinado);
        System.debug('defensor: ' + defensor);

        Boolean contraAtaque = false;

        //não é contraAtaque pois é a primeira chamada ao método.
        iniciarAtaque(atacante, defensor, contraAtaque);
    }

    @TestVisible
    private static void iniciarAtaque(Jogador__c atacante, Jogador__c defensor, Boolean contraAtaque) {
        Integer dadoAtacante = Utils.generateRandonNumberInclusive(1, 20, null);
        System.debug('dadoAtacante: ' + dadoAtacante);

        //TODO: tratar nulo
        Integer dadoAtaque = dadoAtacante + atacante.Forca__c?.intValue();
        System.debug('dadoAtaque: ' + dadoAtaque);

        Integer dadoDefesa = Utils.generateRandonNumberInclusive(1, 10, null) + Utils.generateRandonNumberInclusive(1, 10, null) 
                        + defensor.Inteligencia__c.intValue() + defensor.Velocidade__c.intValue();
        System.debug('dadoDefesa: ' + dadoDefesa);

        if (isDadosAtaqueDefesaInformados(dadoAtaque, dadoDefesa)) {
            if (isAtaqueMaiorQueDefesa(dadoAtaque, dadoDefesa)) {
                System.debug('--# ATAQUE MAIOR QUE DEFESA #--');
                Assassinato__c jogadorAssassinado = assassinarJogador(atacante, defensor);
                System.debug('jogadorAssassinado: ' + jogadorAssassinado);
    
                insert jogadorAssassinado;
            } else {
                if (isContraAtaque(dadoAtacante, contraAtaque)) {
                    System.debug('--# SEGUUUURAAA O CONTRA ATAQUE #--');
                    //iniciarContraAtaque(atacante, defensor);
                    iniciarAtaque(defensor, atacante, true);
                }
            }
        } else {
            //poderia lançar uma exception de negócio.
            // throw new DadosNaoInformadosException('Dados de combate e/ou Dados de defesa não foram informados')
            System.debug('--# NÃO TEMOS INFORMAÇÕES PARA INICIAR O COMBATE');
        }
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
    private static void iniciarContraAtaque(Jogador__c ataque, Jogador__c defesa) {
        System.debug('--# INICIANDO O CONTRA ATAQUE #--');
        Jogador__c jogadorAux = ataque;
        Jogador__c jogadoAtaque = defesa;
        Jogador__c jogadorDefesa = jogadorAux;
        iniciarAtaque(ataque, defesa, true); 
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