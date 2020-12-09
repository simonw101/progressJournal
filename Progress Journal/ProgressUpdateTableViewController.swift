//
//  ProgressUpdateTableViewController.swift
//  Progress Journal
//
//  Created by Simon Wilson on 08/12/2020.
//

import UIKit

class ProgressUpdateTableViewController: UITableViewController {
    
    var updates : [ProgressUpdate] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreDataInfo()
    }
    
    func getCoreDataInfo() {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let progressUpdateItems = try? context.fetch(ProgressUpdate.fetchRequest()) as? [ProgressUpdate] {
                
                updates = progressUpdateItems
                
                tableView.reloadData()
                
            }
            
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return updates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath)

        // Configure the cell...
        
        if let imageData = updates[indexPath.row].image {
            
            cell.imageView?.image = UIImage(data: imageData)
            
        }
        
        cell.textLabel?.text = updates[indexPath.row].title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let progressUpdate = updates[indexPath.row]
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                context.delete(progressUpdate)
                
                getCoreDataInfo()
                
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let progressUpdate = updates[indexPath.row]
        
        performSegue(withIdentifier: "showUpdate", sender: progressUpdate)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewProgressVC = segue.destination as? ViewProgressUpdateViewController {
            
            if let progressUpdate = sender as? ProgressUpdate {
                
                viewProgressVC.progressUpdate = progressUpdate
                
            }
            
            
            
        }
        
    }
    

}
