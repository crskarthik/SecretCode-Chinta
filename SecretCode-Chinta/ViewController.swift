//
//  ViewController.swift
//  SecretCode-Chinta
//
//  Created by Raja Srikar Karthik Chinta on 2/28/18.
//  Copyright © 2018 Raja Srikar Karthik Chinta. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select characters below"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDelegate.codeModel.Symbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "symbol")
        cell?.textLabel?.text = AppDelegate.codeModel.Symbols[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        AppDelegate.codeModel.addSymbol(sym: AppDelegate.codeModel.Symbols[indexPath.row])
        GuessLBL.text="Your Guess is \(AppDelegate.codeModel.currentGuess())"
        StatusLBL.text=AppDelegate.codeModel.statusOfGuess()
        HintLBL.text = ""
        if AppDelegate.codeModel.Guess.count == AppDelegate.codeModel.Count {
            AppDelegate.codeModel.Guess=[]
            UndoBTN.isEnabled=false
            ResetBTN.isEnabled=true
        } else if AppDelegate.codeModel.Guess.count != 0{
            UndoBTN.isEnabled = true
            ResetBTN.isEnabled=true
        }
    }
    @IBOutlet weak var GuessLBL: UILabel!
    @IBOutlet weak var StatusLBL: UILabel!
    
    @IBOutlet weak var UndoBTN: UIButton!
    @IBOutlet weak var ResetBTN: UIButton!
    @IBOutlet weak var HintLBL: UILabel!
    @IBAction func ResetBTNAction(_ sender: Any) {
        AppDelegate.codeModel.reset()
        ResetBTN.isEnabled = false
        UndoBTN.isEnabled = false
        GuessLBL.text = ""
        StatusLBL.text = ""
        AppDelegate.codeModel.Attempts = 1
    }
    @IBAction func UndoBTNAction(_ sender: Any) {
        if AppDelegate.codeModel.Guess.count != AppDelegate.codeModel.Count || AppDelegate.codeModel.Guess.count != 0 {
            AppDelegate.codeModel.undoSymbol()
            GuessLBL.text="Your Guess is \(AppDelegate.codeModel.currentGuess())"
            StatusLBL.text=AppDelegate.codeModel.statusOfGuess()
        }
    }
    @IBAction func HintBTNAction(_ sender: Any) {
        if AppDelegate.codeModel.Guess.count < AppDelegate.codeModel.Code.count{
            HintLBL.text = "Next character in code is \(AppDelegate.codeModel.Code[AppDelegate.codeModel.Guess.count])"
        }
    }
}

