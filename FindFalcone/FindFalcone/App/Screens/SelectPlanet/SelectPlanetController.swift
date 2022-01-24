//
//  SelectPlanetVC.swift
//  FindFalcone
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import UIKit
import FalconeCore

final class SelectPlanetController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var planets = [Planet]()
    var currentPlanet: Planet?
    var onSelectedPlanet: ((Planet) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SelectPlanetController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let planet = planets[indexPath.row]

        cell.textLabel?.text = planet.name
        cell.accessoryType = planet.name == currentPlanet?.name ? .checkmark : .none
        return cell
    }
}

extension SelectPlanetController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectedPlanet?(planets[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
