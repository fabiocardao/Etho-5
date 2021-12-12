public without sharing class CandidatosCEPAlteradosSchedulable implements Schedulable {
    public Database.QueryLocator start(Database.BatchaBleContext BC) {
        return Database.getQueryLocator(CandidatosSelector.getQueryLocatorBatchable());
    }

    public void execute(SchedulableContext sc) {
    Database.executeBatch(new CandidatosCEPAlteradoBatchable(), 200);
    }

    public void finish(Database.BatchableContext BC) {}
}
