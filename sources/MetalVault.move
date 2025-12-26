module bambo_addr::metal_vault{
    use std::string::{String, utf8};
    use std::simple_map::{SimpleMap, Self};
    use std::debug::print;

    struct MetalReserves has store, copy, drop{
        g28: SimpleMap<String, u64>,
        g57: SimpleMap<String, u64>,
        g114: SimpleMap<String, u64>,
    }

    struct MetalVault has key, copy , drop{
        gold: MetalReserves,
        silver: MetalReserves
    } 

    fun init_client(account : &signer){
        let metal_vault: SimpleMap<String, u64> = simple_map::create();
        simple_map::add(&mut metal_vault, utf8(b"UAE"), 0)
        simple_map::add(&mut metal_vault, utf8(b"MEX"), 0)
        simple_map::add(&mut metal_vault, utf8(b"COL"), 0)
    }
}