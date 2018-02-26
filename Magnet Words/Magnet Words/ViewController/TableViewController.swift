//
//  TableViewController.swift
//  Book Word Magnets
//
//  Created by Student on 2/16/18.
//  Copyright © 2018 Steven Domitrz. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var themes: [Theme] = []
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = themes[indexPath.row].getName()
        
        if(indexPath.row == selectedRow) {
            self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        }

        return cell
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
