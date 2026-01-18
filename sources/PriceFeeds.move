module bambo_addr::price_feeds {
    use std::vector;
    use std::string::{String, utf8};
    use std::timestamp;
    use std::signer;

    struct TokenFeed has store, drop, copy {
        last_price: u64,
        timestamp: u64,
    }

    struct PriceFeeds has key, store, drop, copy {
        symbols: vector<String>,
        data: vector<TokenFeed>
    }

    const ENOT_OWNER : u64 = 101;

    fun init_module(owner: &signer) {
    let symbols = vector::empty<String>();
    vector::push_back(&mut symbols, utf8(b"BTC"));

    let feed = TokenFeed { last_price: 0, timestamp: 0 };
    let data = vector::singleton(feed);

    move_to(owner, PriceFeeds { symbols, data });
    }


    public entry fun update_feed(owner: &signer, last_price: u64, symbol: String) acquires PriceFeeds {
        let signer_addr = signer::address_of(owner);
        assert!(signer_addr == @bambo_addr, ENOT_OWNER);
        let time = timestamp::now_seconds();
        let data_store = borrow_global_mut<PriceFeeds>(@bambo_addr);
        let new_feed = TokenFeed {
            last_price,
            timestamp: time,
        };
        let (result, index) = vector::index_of(&data_store.symbols, &symbol);
        if (result == true) {
            vector::remove(&mut data_store.data, index);
            vector::insert(&mut data_store.data, index, new_feed);
        } else {
            vector::push_back(&mut data_store.symbols, symbol);
            vector::push_back(&mut data_store.data, new_feed);
        }
    }


    #[view]
    public fun get_token_price(symbol: String): TokenFeed acquires PriceFeeds {
        let data_ref = borrow_global<PriceFeeds>(@bambo_addr);
        let (result, index) = vector::index_of(&data_ref.symbols, &symbol);
        
        if (result == true) {
            *vector::borrow(&data_ref.data, index)
        } else {
            TokenFeed {
                last_price: 0,
                timestamp: 0,
            }
        }
    }

    #[test_only]
    use std::debug::print;

    #[test(owner = @bambo_addr, init_addr = @0x1)]
    fun test_function(owner: signer, init_addr: signer) {
    timestamp::set_time_has_started_for_testing(&init_addr);

    let owner_ref = &owner;

    init_module(owner_ref);
    update_feed(owner_ref, 50_000, utf8(b"BTC"));

    let result = get_token_price(utf8(b"BTC"));
    print(&result);

    update_feed(owner_ref, 2300, utf8(b"ETH"));
    result = get_token_price(utf8(b"ETH"));
    print(&result); 

    update_feed(owner_ref, 78236, utf8(b"BTC"));
    result = get_token_price(utf8(b"BTC"));
    print(&result); 


}

}