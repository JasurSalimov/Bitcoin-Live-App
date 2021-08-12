//
//  ViewController.swift
//  Bitcoin Rate Live
//
//  Created by Jasur Salimov on 8/12/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }
 


}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate{
    func didUpdateCurrency(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinManager.currencyPicked
            self.bitcoinLabel.text = String(round(10*coinModel.rate)/10)
            
        }
    }
}


//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        coinManager.pickerPicked(row: row)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        coinManager.currencyArray.count
    }

    
}
