trigger CandidatosTrigger on Candidato__c (after update) {

    List<Candidato__c>  candidatosCEP = new List<Candidato__c>();

    for (Candidato__c candidato : (List<Candidato__c>) Trigger.new) {
        if (candidato.CEPAlterado__c) {
            System.debug('cep alterado: ' + candidato);
            candidatosCEP.add(candidato);
        }
    }

    System.enqueueJob(new CandidatosCEPQueueable(candidatosCEP));
}