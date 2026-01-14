module bambo_addr::vectors_one{
    use std::vector;
    use std::debug::print as p;
    use std::string::utf8;

    fun vector_basics () : vector<u64>{
        let list = vector::empty<u64>();

        vector::push_back(&mut list, 10);
        vector::push_back(&mut list, 20);


        vector::insert(&mut list, 2, 30);
        vector::insert(&mut list, 3, 50);
        vector::insert(&mut list, 2, 20);

        vector::swap(&mut list, 1, 0);

        let value = *vector::borrow_mut(&mut list, 2);
        value = value + 10;
        vector::insert(&mut list, 2, value);

        vector::remove(&mut list, 3);

        vector::pop_back(&mut list);
        list


  

    }

    fun while_loop_vector(list: vector<u64>): vector<u64>{
        let length = vector::length(&list);
        let i: u64 = 0;
        while (i < length) {
            let value = *vector::borrow(&list, i);
            p(&value);
            i = i + 1; 
        };
        list
    }

    fun read_element(element: u64){
        p(&element);
        
    }

    fun update_element(element:&mut u64){
        let value = *element + 1;
        p(&value);

    }

    fun for_each_vector(list: vector<u64>){
        p(&utf8(b"For Each"));
        vector::for_each(list, |list | read_element(list));
        p(&utf8(b"For Each Mutable"));
        vector::for_each_mut(&mut list, |list| update_element(list));

    }

  
    

    #[test]
    fun test_function(){
    let list = vector_basics();

    vector::contains(&mut list, &10);
    vector::index_of(&mut list, &30);

    let list = while_loop_vector(list);
    p(&utf8(b" While Loop"));
    for_each_vector(list);
    }

}