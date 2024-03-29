//
//  RecordViewController.swift
//  Millionaire
//
//  Created by Grigory Stolyarov on 21.02.2021.
//

import UIKit

class RecordViewController: UIViewController {
    
    let game = Game.instance
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cleanRecordsDidTapped(_ sender: UIButton) {
        game.clearRecords()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
    }
    
}

extension RecordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.reuseIdentifier, for: indexPath) as! RecordTableViewCell

        let record = game.records[indexPath.row]
        cell.earnLabel.text = "\(record.earned)₽"
        cell.dateLabel.text = dateFormatter.string(from: record.date)
        
        return cell
    }
    
}
