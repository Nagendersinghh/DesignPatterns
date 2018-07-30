//
//  ViewController.swift
//  SportsStore
//
//  Created by nagender singh shekhawat on 23/07/18.
//  Copyright © 2018 nagender singh shekhawat. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockField: UITextField!
    
    var product: Product?
}

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var totalStockLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    let productDataStore = ProductDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productDataStore.callback = {(p: Product) in
            for cell in self.tableView.visibleCells {
                if let pCell = cell as? ProductTableCell {
                    if pCell.product?.name == p.name {
                        pCell.stockStepper.value = Double(p.stockLevel)
                        pCell.stockField.text = String(p.stockLevel)
                    }
                }
            }
            self.displayStockTotal()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stockLevelDidChange(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField {
                            if let newValue = Int(textfield.text!) {
                                product.stockLevel = newValue
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.logItem(item: product)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
    func displayStockTotal() {
        let finalTotals:(Int, Double) = productDataStore.products.reduce(
            (0, 0.0),
            {(totals, product) -> (Int, Double) in
                return (totals.0 + product.stockLevel, totals.1 + product.stockValue)
            }
        )
        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
            + "Total Value: \(Utils.currencyStringFromNumber(number: finalTotals.1))"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDataStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productDataStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
            as! ProductTableCell
        cell.product = product
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        return cell
    }
}

