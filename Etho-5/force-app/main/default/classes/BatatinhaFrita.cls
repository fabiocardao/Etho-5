public class BatatinhaFrita {
    public void execute(Id idPartida){
        ParticipantePartida__c[] participantes = [SELECT Jogador__c FROM ParticipantePartida__c WHERE Partida__c = :idPartida];        
        Jogador__c[] jogadores = new List<Jogador__c>();
        Integer mortes = participantes.size() / 2;
        
        for (Integer i = 0; i < mortes; i++) {
            jogadores.add(new Jogador__c(Id = participantes[i].Jogador__c, Eliminado__c = true));
        }
        
        update jogadores;
        
        update new Partida__c(Id = idPartida, TerminoPartida__c = System.now());
    }
}