module bambo_addr::RefDemo{

use std::debug::print;

fun scenerio_1() {
    let value_a = 10;
    let imm_ref: &u64 = &value_a;
    print(imm_ref);
}

fun scenerio_2() {
    let value_a = 10;
    let mut_ref: &mut u64 = &mut value_a;
    let imm_ref : &u64 = mut_ref;
    print(imm_ref);
}


fun re_assign(value_a: &mut u64, value_b : &u64){
    *value_a = *value_b;
    print(value_a);
}

fun scenerio_3() {
    let value_a: &mut u64 = &mut 10;
    let value_b: &u64 = &20;
    re_assign(value_a, value_b);    
}

#[test]
fun test_function() {
    // scenerio_1();
    // scenerio_2();
    // scenerio_3();
}

}

