@isTest
private class ItemControllerTest {
    
    @testSetup
    static void setup() {

        List<Item__c> testItems = new List<Item__c>();
        
        testItems.add(new Item__c(
            Name = 'Test Laptop',
            Description__c = 'Test laptop description',
            Type__c = 'Type 1',
            Family__c = 'Family 1',
            Price__c = 1000.00,
            Image__c = 'https://test.com/image1.jpg'
        ));
        
        testItems.add(new Item__c(
            Name = 'Test Mouse',
            Description__c = 'Test mouse description',
            Type__c = 'Type 2',
            Family__c = 'Family 2',
            Price__c = 50.00,
            Image__c = 'https://test.com/image2.jpg'
        ));
        
        testItems.add(new Item__c(
            Name = 'Test Keyboard',
            Description__c = 'Test keyboard description',
            Type__c = 'Type 1',
            Family__c = 'Family 1',
            Price__c = 100.00,
            Image__c = 'https://test.com/image3.jpg'
        ));
        
        insert testItems;
        
    
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
    }
    
    @isTest
    static void testGetItemsNoFilters() {
        Test.startTest();
        List<Item__c> items = ItemController.getItems('', '', '');
        Test.stopTest();
        
        System.assertEquals(3, items.size(), 'Should return all 3 items');
    }
    
    @isTest
    static void testGetItemsWithSearch() {
        Test.startTest();
        List<Item__c> items = ItemController.getItems('Laptop', '', '');
        Test.stopTest();
        
        System.assertEquals(1, items.size(), 'Should return 1 item');
        System.assertEquals('Test Laptop', items[0].Name, 'Should return the laptop');
    }
    
    @isTest
    static void testGetItemsWithTypeFilter() {
        Test.startTest();
        List<Item__c> items = ItemController.getItems('', 'Type 1', '');
        Test.stopTest();
        
        System.assertEquals(2, items.size(), 'Should return 2 items with Type 1');
    }
    
    @isTest
    static void testGetItemsWithFamilyFilter() {
        Test.startTest();
        List<Item__c> items = ItemController.getItems('', '', 'Family 1');
        Test.stopTest();
        
        System.assertEquals(2, items.size(), 'Should return 2 items with Family 1');
    }
    
    @isTest
    static void testGetItemsWithAllFilters() {
        Test.startTest();
        List<Item__c> items = ItemController.getItems('Laptop', 'Type 1', 'Family 1');
        Test.stopTest();
        
        System.assertEquals(1, items.size(), 'Should return 1 item matching all filters');
        System.assertEquals('Test Laptop', items[0].Name);
    }
    
    @isTest
    static void testGetPicklistValues() {
        Test.startTest();
        Map<String, List<String>> picklistValues = ItemController.getPicklistValues();
        Test.stopTest();
        
        System.assert(picklistValues.containsKey('Type'), 'Should contain Type picklist');
        System.assert(picklistValues.containsKey('Family'), 'Should contain Family picklist');
        System.assert(picklistValues.get('Type').size() > 0, 'Type should have values');
        System.assert(picklistValues.get('Family').size() > 0, 'Family should have values');
    }
    
    @isTest
    static void testCreatePurchase() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Item__c testItem = [SELECT Id, Price__c FROM Item__c LIMIT 1];
        

        List<ItemController.CartItem> cartItems = new List<ItemController.CartItem>();
        ItemController.CartItem cartItem = new ItemController.CartItem();
        cartItem.itemId = testItem.Id;
        cartItem.quantity = 2;
        cartItem.price = testItem.Price__c;
        cartItems.add(cartItem);
        
        String cartJson = JSON.serialize(cartItems);
        
        Test.startTest();
        Id purchaseId = ItemController.createPurchase(testAccount.Id, cartJson);
        Test.stopTest();
        
    
        Purchases__c purchase = [SELECT Id, ClientId__c FROM Purchases__c WHERE Id = :purchaseId];
        System.assertEquals(testAccount.Id, purchase.ClientId__c, 'Purchase should be linked to account');
        
    
        List<PurchaseLine__c> lines = [SELECT Id, Amount__c, UnitCost__c FROM PurchaseLine__c WHERE PurchaseId__c = :purchaseId];
        System.assertEquals(1, lines.size(), 'Should have 1 purchase line');
        System.assertEquals(2, lines[0].Amount__c, 'Amount should be 2');
    }
}