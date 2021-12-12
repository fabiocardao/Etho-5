public with sharing class CandidatosHandler {
    public static Candidato__c handleCepAlterado(Boolean valor, Candidato__c candidato) {
        System.debug('CEPAlterado__c: ' + valor);
        candidato.CEPAlterado__c = valor;
        return candidato;
    }

    public static void atualizarCandidato(List<Candidato__c> candidatos) {
        update candidatos;
    }
}
