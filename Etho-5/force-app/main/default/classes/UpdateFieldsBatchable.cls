public with sharing class UpdateFieldsBatchable implements Database.Batchable<sObject>, Database.Stateful {
    
    String query;
    Map<SObjectField, Object> mapa;
    String errorMessageHtml;


    public UpdateFieldsBatchable(String query, Map<SObjectField, Object> mapa) {
        this.query = query;
        this.mapa = mapa;
    }

    public Database.QueryLocator start(Database.BatchaBleContext BC) {
        System.debug('PASSOU NO START');
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<SObject> scope) {
        System.debug('ENTROU NO EXECUTE');
        System.debug('SCOPE: ' + JSON.serialize(scope));

        for (SObject record : scope) {
            for (Schema.SOBjectField key : mapa.keySet()) {
                record.put(key, mapa.get(key));
            }
        }

        List<Database.SaveResult> srList = Database.update(scope, false);
        handleLog(srList, scope);
    }

    public void finish(Database.BatchableContext BC) {
        System.debug('PASSOU NO FINISH');
        sendLog();
    }

    private void handleLog(List<Database.SaveResult> srList, List<Candidato__c> scope) {
        for (Integer i = 0; i < scope.size(); i++) {
            if (!srList.get(i).isSuccess()) {
                errorMessageHtml += '====== [' + 'Erro ao atualizar o registro: ' + scope.get(i).Id + '] ====<br/>' ;
                for (Database.Error err: srList.get(i).getErrors()) {
                    errorMessageHtml += 'Mensagem: ' + err.getMessage() + '<br/>';
                }
            } else {
                errorMessageHtml += '====== [' + 'Registros atualizados com sucesso! ]======<br/>' ;
                System.debug('errorMessageHtml: ' + errorMessageHtml);
            }
        }
    }

    private void sendLog() {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(new List<String>{'fabio.cardao@gmail.com'});
        message.setSubject('Log de erros');
        System.debug('sendLog: ' + errorMessageHtml); 
        message.setHtmlBody(errorMessageHtml);
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>{message};
        
        Messaging.sendEmail(messages);
    }
}
