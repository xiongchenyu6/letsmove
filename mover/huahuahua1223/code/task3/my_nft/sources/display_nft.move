module my_nft::display_nft{
    use std::string;
    use std::string::{utf8, String};
    use sui::tx_context::{sender};
    use sui::package;
    use sui::display;

    public struct MyNFT has key, store {
        id: UID,
        name: String,
        image_url: String,
    }
    
    public struct DISPLAY_NFT has drop {}
    
    fun init(otw: DISPLAY_NFT, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"link"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"project_url"),
            utf8(b"creator"),
        ];

        let values = vector[
            utf8(b"{name}"),
            utf8(b"https://sui-heroes.io/hero/{id}"),
            utf8(b"{image_url}"),
            utf8(b"A true Hero of the Sui ecosystem!"),
            utf8(b"https://sui-heroes.io"),
            utf8(b"Unknown Sui Fan")
        ];

        let publisher = package::claim(otw, ctx);

        let mut display = display::new_with_fields<MyNFT>(
            &publisher, keys, values, ctx
        );

        display::update_version(&mut display);

        transfer::public_transfer(publisher, sender(ctx));
        transfer::public_transfer(display, sender(ctx));

        let nft = MyNFT {
            id: object::new(ctx),
            name: string::utf8(b"huahuahua1223 display nft"),
            image_url: string::utf8(b"https://avatars.githubusercontent.com/u/138219491"),
        };
        
        transfer::public_transfer(nft, sender(ctx));
    }


    public entry fun mint(name: String, image_url: String, ctx: &mut TxContext) {
        let id = object::new(ctx);
        let nft =  MyNFT { id, name, image_url };
        transfer::public_transfer(nft, sender(ctx));
    }
}

