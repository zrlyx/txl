//
//  File2.swift
//  txl
//
//  Created by  20141105042hyb on 16/7/8.
//  Copyright © 2016年 20141105042HYB. All rights reserved.
//

import UIKit

class File2: UIViewController {
    var db:SQLiteDB!
    
    
    @IBOutlet weak var xianshi: UITextField!
    
    @IBOutlet weak var xianshi1: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists user(uid integer primary key,uname varchar(20),mobile varchar(20),email varcher(20),address varcher(20))")
        //如果有数据则加载
        //initUser()
    }
    
    @IBAction func dianji(sender: AnyObject) {
    
            sf()
    }
    func sf(){
        xianshi1.text=""
        let a=xianshi.text!
        let data = db.query("select * from user where uname='\(a)'")
        for (var i=0;i<data.count;i++)
        {//获取最后一行数据显示
            let tuser = data[i]
            xianshi1.text! += "姓名：" + String(tuser["uname"]!) + " 电话：" + String(tuser["mobile"]!)  + " email：" + String(tuser["email"]!) +  " 地址：" + String(tuser["address"]!)+"\n"
        }
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}