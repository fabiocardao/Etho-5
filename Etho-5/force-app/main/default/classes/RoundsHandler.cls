public with sharing class RoundsHandler {
    public static void iniciarRound(Jogador__c jogador) {
        System.debug('--# INICIANDO ROUND #--');

        Round__c round = new Round__c(
            Id = jogador.Round__r.Id,
            InicioJogos__c = DateUtil.retornarDatetime().date()
        );

        update round;
    }

    public static void encerrarRound(Jogador__c campeao) {
        System.debug('--# ENCERRANDO O ROUND #--');

        Round__c round = new Round__c(
            TerminoJogos__c = DateUtil.retornarDatetime().date(),
            Vencedor__c = campeao.Id,
            Status__c = 'Finalizado',
            Id = campeao.Round__r.Id
        );

        update round;
    }
}
