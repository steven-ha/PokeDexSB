//
//  PokemonController.swift
//  PokeDexSB
//
//  Created by steven ha on 12/8/19.
//  Copyright © 2019 steven ha. All rights reserved.
//

import UIKit

class PokemonController: UIViewController {
    var pokeID: Int?
    
    var image: UIImage?
    @IBOutlet var pokeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white


//        let _image = URLSession.shared.dataTask(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/45.png")!) { (data, response, err) in
//
//            if let data = data {
//                DispatchQueue.main.async {
//                    self.pokeImage.image = UIImage(data: data)
//                    self.pokeImage.layoutSubviews()
//                }
//            }
//
//
////
////
//        }.resume()
        // Do any additional setup after loading the view.
                DispatchQueue.main.async {
                    self.pokeImage.image = self.image
                    self.pokeImage.layoutSubviews()
    
                }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
