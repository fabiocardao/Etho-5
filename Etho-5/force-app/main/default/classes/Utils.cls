public without sharing class Utils {

    public static void setValue(SObject record, Schema.SObjectField field, Object value) {
        record.put(field, value);
    }

    public static Boolean isMembroStaff(String recordTypeDeveloperName) {
        return recordTypeDeveloperName.equals(Label.RECORD_TYPE_DEVELOPER_NAME_MEMBRO_STAFF);
    }

    /*public static Integer generateRandomNumber(Integer numero) {
        return Integer.valueOf(Math.random() * numero);
    }*/

    public static Integer generateRandonNumberInclusive(Integer posicaoInicial, Integer posicaoFinal, Integer jaSorteado) {
        Integer resultado;

        while (resultado == null || resultado == jaSorteado) {
            resultado = Integer.valueOf(Math.floor(Math.random() * (posicaoFinal - posicaoInicial + 1)) + posicaoInicial);
        }
        return resultado;
    }

    //TODO: desenvolver esse cálculo aleatório.
    //retornar número aleatório entre X e Y (inclusivo)
    //x <= retorno <= y
    /*public static Integer generateRandomIntegerBetween(Integer x, Integer y, Integer numero) {
        return (y - x);
    }*/

    /*public static Integer generateRandomIntegerBetween(Integer x, Integer y) {
        return Integer.valueof((Math.random() * (x - y + 1)) + x);
    }*/
    
}