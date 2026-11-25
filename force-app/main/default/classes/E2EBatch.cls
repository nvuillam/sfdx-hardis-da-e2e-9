public with sharing class E2EBatch implements Database.Batchable<SObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Name LIKE 'DA_E2E%']);
    }
    public void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Description = 'batched-by-da-e2e';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc) {
    }
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new E2EBatch());
    }
}
