public with sharing class CandidatosCEPQueueable implements Queueable {
    List<Candidato__c> candidatos;

    public CandidatosCEPQueueable(List<Candidato__c> candidatos) {
        this.candidatos = candidatos;
    }

    public void execute(QueueableContext context) {
        for (Candidato__c candidato : candidatos) {
            System.debug('candidato: ' + candidato.Name);
        }
    }
}