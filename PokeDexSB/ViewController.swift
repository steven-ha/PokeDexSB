//
//  ViewController.swift
//  PokeDexSB
//
//  Created by steven ha on 12/7/19.
//  Copyright © 2019 steven ha. All rights reserved.
//

import UIKit

enum PokeMonURL {
    static let main = "https://pokeapi.co/api/v2/pokemon/"
}

class ViewController: UITableViewController {
    
    var arr = Array<Pokemon?>(repeating: nil, count: 151)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let semaphore = DispatchSemaphore(value: 1)
        
        var count = 0

        print("gonna catch them all!")
            for i in 1...151 {
                semaphore.wait()

                let _ = URLSession.shared.dataTask(with: URL(string: "\(PokeMonURL.main)/\(i)")!) { (data, response, error) in

                    if let data = data {
                        // print(try! JSONSerialization.jsonObject(with: data, options: []))
                        let pokemon = try! JSONDecoder().decode(Pokemon.self, from: data)
                        self.arr[i-1] = pokemon
                        count += 1
                        semaphore.signal()

                        print(pokemon)
                    }

                }.resume()


            }
        
        semaphore.wait()
        if arr.count == 151 {
            semaphore.signal()

        }
            print("captured them all!")

        tableView.reloadData()
            
        

    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(sender)
        if segue.identifier == "showPokemon" {
            if let indexPath = sender as? UITableViewCell {
                let controller = segue.destination as! PokemonController
                print(indexPath)
                controller.pokeID = tableView.indexPathForSelectedRow!.row + 1
                print(images[tableView.indexPathForSelectedRow!.row])
                print(self.images)
                controller.image = images[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    
    var images = Array<UIImage>(repeating: UIImage(), count: 151)

    var pokeID: Int?
}

extension ViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokeID = indexPath.row + 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 151
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        cell.textLabel?.text = "\(arr[indexPath.row]!.name)"
        
        let _image = URLSession.shared.dataTask(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(indexPath.row + 1).png")!) { (data, response, err) in
            let image = UIImage(data: data!)!
            self.images[indexPath.row] = image
            DispatchQueue.main.async {
                            cell.imageView?.image = image
                cell.layoutSubviews()

            }
        }.resume()
        
        return cell
    }
    
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    //let sprites: [String: String]
}
