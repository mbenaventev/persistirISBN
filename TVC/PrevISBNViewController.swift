//
//  PrevISBNViewController.swift
//  TVC
//
//  Created by Miguel Benavente Valdés on 02/05/16.
//  Copyright © 2016 Miguel Benavente Valdés. All rights reserved.
//

import UIKit

class PrevISBNViewController: UIViewController {
    
    var txtISBN : String = ""
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var imgPortada: UIImageView!
    @IBOutlet weak var lblAutores: UILabel!
    @IBOutlet weak var lblPortada: UILabel!
    @IBOutlet weak var lblMensaje: UILabel!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string:urls + txtISBN)
        let datos = NSData(contentsOfURL:url!)
        let datos2 : NSData? = NSData(contentsOfURL:url!)
        if datos2 != nil{
            let texto = NSString(data : datos!, encoding: NSUTF8StringEncoding )
            print(datos)
            print(datos2)
            print(texto)
            if texto != "{}"{
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    let dico1 = json as! NSDictionary
                    let dico2 = dico1["ISBN:" + txtISBN] as! NSDictionary //978-84-376-0494-7
                    let dico3 = dico2["authors"]! [0] as! NSDictionary
                    let dico4 = dico2["cover"]! as! NSDictionary
                    
                    self.lblTitulo.text = dico2["title"] as! NSString as String
                    self.lblAutores.text = dico3["name"] as! NSString as String
                    self.lblPortada.text = dico4["large"] as! NSString as String //"No se encontroó información"
                    if self.lblPortada.text != "" {
                        let imgURLs = lblPortada.text
                        let imgURL = NSURL(string: imgURLs!)
                        let imgDatos = NSData(contentsOfURL: imgURL!)
                        if let imagen = UIImage(data: imgDatos!){
                            imgPortada.image = imagen
                        }
                    }
                }
                catch _{
                    
                }
                
                
                lblMensaje.text="La conexión se realizo correctamente"
                lblMensaje.textColor=UIColor.darkGrayColor()
            }
            else{
                lblMensaje.text="No se encontró el recurso que buscas"
                lblMensaje.textColor=UIColor.orangeColor()
                lblTitulo.text = ""
                lblAutores.text = ""
                lblPortada.text = ""
            }
        }
        else{
            self.lblMensaje.textColor=UIColor.redColor()
            self.lblMensaje.text="No se realizó la conexión"
            lblTitulo.text = ""
            lblAutores.text = ""
            lblPortada.text = ""
        }
        //itmBtnHecho.enabled = true
        //navItm.rightBarButtonItem?.enabled = true
        //txtISBN.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
