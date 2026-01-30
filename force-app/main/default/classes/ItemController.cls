public with sharing class ItemController {
    
   @AuraEnabled(cacheable=true)
public static List<Item__c> getItems(String searchKey, String typeFilter, String familyFilter) {
    String query = 'SELECT Id, Name, Description__c, Type__c, Family__c, Price__c, Image__c FROM Item__c';
    List<String> conditions = new List<String>();
    
    // Поиск только по имени (Description__c - Long Text Area, нельзя фильтровать)
    if (String.isNotBlank(searchKey)) {
        String searchPattern = '%' + searchKey + '%';
        conditions.add('Name LIKE :searchPattern');
    }
    
    // Фильтр по Type
    if (String.isNotBlank(typeFilter)) {
        conditions.add('Type__c = :typeFilter');
    }
    
    // Фильтр по Family
    if (String.isNotBlank(familyFilter)) {
        conditions.add('Family__c = :familyFilter');
    }
    
    // Добавляем условия к запросу
    if (!conditions.isEmpty()) {
        query += ' WHERE ' + String.join(conditions, ' AND ');
    }
    
    query += ' ORDER BY Name';
    
    return Database.query(query);
}
    
    @AuraEnabled(cacheable=true)
    public static Map<String, List<String>> getPicklistValues() {
        Map<String, List<String>> picklistMap = new Map<String, List<String>>();
        

        List<String> typeValues = new List<String>();
        Schema.DescribeFieldResult typeField = Item__c.Type__c.getDescribe();
        for (Schema.PicklistEntry entry : typeField.getPicklistValues()) {
            if (entry.isActive()) {
                typeValues.add(entry.getValue());
            }
        }
        picklistMap.put('Type', typeValues);

        List<String> familyValues = new List<String>();
        Schema.DescribeFieldResult familyField = Item__c.Family__c.getDescribe();
        for (Schema.PicklistEntry entry : familyField.getPicklistValues()) {
            if (entry.isActive()) {
                familyValues.add(entry.getValue());
            }
        }
        picklistMap.put('Family', familyValues);
        
        return picklistMap;
    }
    
    @AuraEnabled
    public static Id createPurchase(Id accountId, String cartItemsJson) {
        List<CartItem> cartItems = (List<CartItem>) JSON.deserialize(cartItemsJson, List<CartItem>.class);
        
        Purchases__c purchase = new Purchases__c(
            ClientId__c = accountId
        );
        insert purchase;
        
        List<PurchaseLine__c> purchaseLines = new List<PurchaseLine__c>();
        for (CartItem item : cartItems) {
            purchaseLines.add(new PurchaseLine__c(
                PurchaseId__c = purchase.Id,
                ItemId__c = item.itemId,
                Amount__c = item.quantity,
                UnitCost__c = item.price
            ));
        }
        insert purchaseLines;
        
        return purchase.Id;
    }
    
    public class CartItem {
        public String itemId;
        public Integer quantity;
        public Decimal price;
    }
}