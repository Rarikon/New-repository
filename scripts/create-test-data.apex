// Создаем тестовые товары
List<Item__c> items = new List<Item__c>();

items.add(new Item__c(
    Name = 'Laptop Dell XPS 15',
    Description__c = 'High performance laptop with 16GB RAM and 512GB SSD',
    Type__c = 'Type 1',
    Family__c = 'Family 1',
    Price__c = 1299.99,
    Image__c = 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853'
));

items.add(new Item__c(
    Name = 'Wireless Mouse Logitech',
    Description__c = 'Ergonomic wireless mouse with precision tracking',
    Type__c = 'Type 2',
    Family__c = 'Family 1',
    Price__c = 29.99,
    Image__c = 'https://images.unsplash.com/photo-1527814050087-3793815479db'
));

items.add(new Item__c(
    Name = 'Mechanical Keyboard',
    Description__c = 'RGB mechanical keyboard with Cherry MX switches',
    Type__c = 'Type 2',
    Family__c = 'Family 1',
    Price__c = 89.99,
    Image__c = 'https://images.unsplash.com/photo-1587829741301-dc798b83add3'
));

items.add(new Item__c(
    Name = 'Monitor 27 inch 4K',
    Description__c = '27 inch 4K UHD monitor with HDR support',
    Type__c = 'Type 1',
    Family__c = 'Family 2',
    Price__c = 449.99,
    Image__c = 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf'
));

items.add(new Item__c(
    Name = 'Noise Cancelling Headphones',
    Description__c = 'Premium over-ear headphones with active noise cancellation',
    Type__c = 'Type 3',
    Family__c = 'Family 3',
    Price__c = 299.99,
    Image__c = 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
));

items.add(new Item__c(
    Name = 'USB-C Hub',
    Description__c = 'Multi-port USB-C hub with HDMI and card reader',
    Type__c = 'Type 4',
    Family__c = 'Family 2',
    Price__c = 49.99,
    Image__c = 'https://images.unsplash.com/photo-1625948515291-69613efd103f'
));

items.add(new Item__c(
    Name = 'Webcam HD 1080p',
    Description__c = 'Full HD webcam with auto-focus and stereo microphones',
    Type__c = 'Type 3',
    Family__c = 'Family 3',
    Price__c = 79.99,
    Image__c = 'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04'
));

items.add(new Item__c(
    Name = 'External SSD 1TB',
    Description__c = 'Portable solid state drive with USB 3.2 Gen 2',
    Type__c = 'Type 4',
    Family__c = 'Family 4',
    Price__c = 129.99,
    Image__c = 'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b'
));

insert items;

System.debug('Successfully created ' + items.size() + ' test items');