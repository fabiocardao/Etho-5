public without sharing class RoundsTriggerHandler {

    static FINAL String STATUS_ROUND_SUSPENSO = 'Suspenso';
    static FINAL String STATUS_ROUND_FINALIZADO = 'Finalizado';
   
    public static void afterUpdate(List<Round__c> records, Map<Id, Round__c> oldMap) {
        Map<Id, Round__c> recordsWithJogadores = new Map<Id, Round__c>(RoundsSelector.selectByRoundsIdsWithJogadores(oldMap.keySet()));
        List<Jogador__c> jogadoresToUpdate = new List<Jogador__c>();

        for (Round__c record : records) {
            afterUpdate(record, oldMap.get(record.Id), recordsWithJogadores.get(record.Id).Jogadores__r, jogadoresToUpdate);
        }

        update jogadoresToUpdate;
    }

    private static void afterUpdate(Round__c record, Round__c recordOld, List<Jogador__c> jogadoresRound, List<Jogador__c> jogadoresToUpdate) {
        handleSuspensao(record, recordOld, jogadoresRound, jogadoresToUpdate);
    }

    //TODO: não pagar família de membro do staff e cálculo não deverá considerá-lo como jogador.
    //Se o campo Premio__c estiver considerando esse cara, o campo está errado.
    //Se o campo TotalJogadoresEliminados__c estiver considerando esse cara, o campo está errado.
    private static void handleSuspensao(Round__c record, Round__c recordOld, List<Jogador__c> jogadoresRound, List<Jogador__c> jogadoresToUpdate) {
        if (!jogadoresRound.isEmpty() && roundFinalizadoPorSuspensao(record.Status__c, recordOld.Status__c)) {
            setValorPagarMortos(getPremioReal(record.PremioTotal__c, jogadoresRound), jogadoresRound);
            jogadoresToUpdate.addAll(jogadoresRound);
        }
    }

    private static Boolean roundFinalizadoPorSuspensao(String status, String statusOld) {
        return statusOld.equals(STATUS_ROUND_SUSPENSO) && status.equals(STATUS_ROUND_FINALIZADO);
    }

    private static void setValorPagarMortos(Decimal premio, List<Jogador__c> jogadoresRound) {
        Decimal premioReal = getPremioReal(premio, jogadoresRound);
        
        for (Jogador__c jogador : jogadoresRound) {
            if (Utils.isMembroStaff(jogador.RecordType.DeveloperName)) {
                Utils.setValue(jogador, Jogador__c.ValorPagar__c, premioReal); 
            }
        }    
    }

    private static Decimal getPremioReal(Decimal premio, List<Jogador__c> jogadoresRound) {
        Integer qtdMembroStaff = 0;
        Integer i = 0;

        for (Jogador__c jogador : jogadoresRound) {
            if (Utils.isMembroStaff(jogador.RecordType.DeveloperName)) {
                qtdMembroStaff++;
            }
        }

        return calculaPremioUnitarioReal(premio, jogadoresRound.size(), qtdMembroStaff);
    }

    private static Decimal calculaPremioUnitarioReal(Decimal premio, Integer qtdJogadores, Integer qtdMembrosStaff) {
        Decimal premioTotal = premio;
        Decimal premioUnitario = premio / qtdJogadores;
        Decimal premioNaoconsiderandoStaff = premioTotal - (premioUnitario * qtdMembrosStaff);
        Decimal qtdJogadoresValidos = qtdJogadores - qtdMembrosStaff;

        return premioNaoconsiderandoStaff / qtdJogadoresValidos;
    }
}