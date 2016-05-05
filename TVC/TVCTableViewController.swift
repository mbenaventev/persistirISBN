//
//  TVCTableViewController.swift
//  TVC
//
//  Created by Miguel Benavente Valdés on 28/04/16.
//  Copyright © 2016 Miguel Benavente Valdés. All rights reserved.
//

import UIKit
import CoreData



class TVCTableViewController: UITableViewController{

    var recibe: String = ""
    var isbn: String = ""
    var titulo: String = ""
    
    var libros : Array<Array<String>> = Array<Array<String>> ()
    
    var contexto : NSManagedObjectContext? = nil
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(isbn, "-",titulo)
        
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let libroEntidad = NSEntityDescription.entityForName("Libro", inManagedObjectContext: self.contexto!)
        //let peticion = libroEntidad?.managedObjectModel.fetfetchRequestFromTemplateWithName("petISBNs", substitutionVariables: )
        let peticion = libroEntidad?.managedObjectModel.fetchRequestTemplateForName("petISBNs")
        do {
            let libroEntidad2 = try self.contexto?.executeFetchRequest(peticion!)
            if (libroEntidad2!.count > 0){
                print("Mayor a 0 - ", String(libroEntidad2!.count))
                for libroEntidad3 in libroEntidad2! {
                    let isbn_ = libroEntidad3.valueForKey("isbn") as! String
                    let titulo_ = libroEntidad3.valueForKey("titulo") as! String
                    self.libros.append([titulo_,isbn_])
                }
            }
            else{
                print("no hay datos")
            }
        }
        catch{
            
        }
        
        //Inserta
            //var entidad = Set<NSObject>()
        if (isbn != ""){
            let nuevoLibro = NSEntityDescription.insertNewObjectForEntityForName("Libro", inManagedObjectContext: self.contexto!)
            nuevoLibro.setValue(isbn, forKey: "isbn")
            nuevoLibro.setValue(titulo, forKey: "titulo")
            //entidad.insert(nuevoLibro)
            do{
                try self.contexto?.save()
            }
            catch{
                
            }
        }
        //end inserta
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.libros.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.libros[indexPath.row][0]
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PrevISBNSegue" {
            let cc = segue.destinationViewController as! PrevISBNViewController
            let ip = self.tableView.indexPathForSelectedRow
            cc.txtISBN = self.libros[ip!.row][1]
        }
    }
    

}
