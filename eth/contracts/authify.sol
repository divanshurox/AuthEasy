pragma solidity ^0.4.17;
pragma experimental ABIEncoderV2;

contract authify{

    struct Customer{
        string name;
        string phone;
        string[] products;
        bool isValue;
    }

    struct Seller{
        string name;
        string location;
        string[] products;
        bool isValue;
    }

    struct Product{
        string name;
        string description;
        string manufacturerName;
        string retailer;
        string[] customers;
    }

    mapping(string => Customer) customerArr;
    mapping(string => Seller) sellerArr;
    mapping(string => Product) productArr;


    function createCustomer(string _hashedEmail,string _name,string _phone) public payable returns (bool) {
        if(customerArr[_hashedEmail].isValue){
            return false;
        }
        Customer memory c;
        c.name = _name;
        c.phone = _phone;
        customerArr[_hashedEmail] = c;
        return true;
    }

    function createProduct(string _code,string _name,string _desc,string _manufacturerName,string _retailer) public payable returns (uint) {
        Product memory p;
        p.description = _desc;
        p.manufacturerName = _manufacturerName;
        p.name = _name;
        p.retailer = _retailer;
        productArr[_code] = p;
        return 1;
    }

    function createSeller(string _hashedEmail,string _name,string _location) public payable returns (bool) {
        if(!sellerArr[_hashedEmail].isValue){
            return false;
        }
        Seller memory s;
        s.name = _name;
        s.location = _location;
        return true;
    }

    function getProductDetails(string _code) public view returns (string,string,string,string) {
        Product memory p = productArr[_code];
        return (p.name,p.description,p.manufacturerName,p.retailer);
    }

    function getCustomerDetails(string _hashedEmail) public view returns (string,string) {
        Customer memory c = customerArr[_hashedEmail];
        return (c.name,c.phone);
    }

    function getSellerDetails(string _hashedEmail) public view returns (string,string) {
        Seller memory c = sellerArr[_hashedEmail];
        return (c.name,c.location);
    }

    function getProductsBySeller(string _hashedEmail) public view returns (string[]){
        return sellerArr[_hashedEmail].products;
    }

    function getProductsByCustomer(string _hashedEmail) public view returns (string[]){
        return customerArr[_hashedEmail].products;
    }

    function addRetailerToProduct(string _code,string _hashedEmail) public payable returns (uint) {
        productArr[_code].retailer = _hashedEmail;
    }

    function changeOwner(string _code,string _oldCustomer,string _newCustomer) public payable returns (bool) {
        uint i;
        bool flag;
        Customer memory oldCustomer = customerArr[_oldCustomer];
        Customer storage newCustomer = customerArr[_newCustomer];
        Product memory product = productArr[_code];
        uint len_oldCustomer_products = oldCustomer.products.length;
        uint len_product_customers = product.customers.length;
        
        // Remove product from oldCustomer's products
        if(oldCustomer.isValue && newCustomer.isValue){
            for(i=0;i<len_oldCustomer_products;i++){
                if(compareStrings(oldCustomer.products[i], _code)){
                    remove(i,customerArr[_oldCustomer].products);
                    newCustomer.products.push(_code);
                    flag = true;
                    break;
                }
            }
        }

        // Remove Old customer from Product's object
        if(flag){
            for(i=0;i<len_product_customers;i++){
                if(compareStrings(product.customers[i],_oldCustomer)){
                    productArr[_code].customers[i] = _newCustomer;
                    break;
                }
            }
        }

        return false;

    }

    function changeInitialOwner(string _code,string _retailer,string _customer) public payable returns (bool) {
        if(compareStrings(productArr[_code].retailer,_retailer)){
            if(customerArr[_customer].isValue){
                customerArr[_customer].products.push(_code);
                productArr[_code].customers.push(_customer);
                return true;
            }
        }
        return false;
    }

    function compareStrings(string _a,string _b) internal returns (bool){
        return keccak256(_a) == keccak256(_b);
    }

    function remove(uint idx,string[] storage stringArr) internal returns (bool) {
        if(idx<stringArr.length){
            return false;
        }
        for(uint i=idx;idx<stringArr.length-1;i++){
            stringArr[i] = stringArr[i+1];
        }
        delete stringArr[stringArr.length-1];
        stringArr.length--;
        return true;
    }


}