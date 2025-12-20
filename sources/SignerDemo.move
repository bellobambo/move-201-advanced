module bambo_addr::SignerDemo {
    use std::signer;
    use std::debug::print;
    use std::string::{String, utf8};

    const NOT_OWNER: u64 = 0;
    const IS_OWNER: address = @bambo_addr;



    fun check_owner(account : signer){
        let address_val = signer::borrow_address(&account);
        assert!(signer::address_of(&account) == IS_OWNER, NOT_OWNER);
        print(&utf8(b"Owner address verified: "));
        print(&signer::address_of(&account));
    }

    #[test(account = @bambo_addr)]
    fun test_function(account : signer){
        // check_owner(account);
    }

}