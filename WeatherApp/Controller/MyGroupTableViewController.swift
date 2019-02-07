//
//  MyGroupTableViewController.swift
//  WeatherApp
//
//  Created by Володя Зверев on 07.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class MyGroupTableViewController: UITableViewController {
    
    var myGroup = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelMyGroup", for: indexPath) as! MyGroupTableViewCell
        cell.labelMyGroup.text = myGroup[indexPath.row]
        return cell
    }
    @IBAction func addGroup(seque:UIStoryboardSegue) {
        
        // Проверяем идентификатор, чтобы убедится, что это нужный переход
        if seque.identifier == "addGroup" {
            // Получаем ссылку на контроллер, с которого осуществлен переход
            let GroupTableViewController = seque.source as! GroupTableViewController
            // Получаем индекс выделенной ячейки
            if let indexPath = GroupTableViewController.tableView.indexPathForSelectedRow {
                // Получаем город по индексу
                let group = GroupTableViewController.allGroup[indexPath.row]
                if !myGroup.contains(group) {
                // Добавляем город в список выбранных городов
                myGroup.append(group)
                // Обновляем таблицу
                tableView.reloadData()
                }
            }
        }
        

    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка «Удалить»
        if editingStyle == .delete {
            // Удаляем город из массива
            myGroup.remove(at: indexPath.row)
            // И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
