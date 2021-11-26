public without sharing class Utils {
    public static void setValue(SObject record, Schema.SObjectField field, Object value) {
        record.put(field, value);
    }

    public static Boolean isMembroStaff(String recordTypeDeveloperName) {
        return recordTypeDeveloperName.equals(Label.RECORD_TYPE_DEVELOPER_NAME_MEMBRO_STAFF);
    }
}