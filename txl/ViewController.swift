//
//  ViewController.swift
//  txl
//
//  Created by  20141105042hyb on 16/7/8.
//  Copyright © 2016年 20141105042HYB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var db:SQLiteDB!
    
    @IBOutlet weak var xingming: UITextField!
    
    @IBOutlet weak var dianhua: UITextField!
    
    @IBOutlet weak var dizhi: UITextField!
    
    @IBOutlet weak var youxiang: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists user(uid integer primary key,uname varchar(20),mobile varchar(20),email varcher(20),address varcher(20))")
        //如果有数据则加载
        initUser()
    }
    
    //点击保存
    
    @IBAction func save(sender: AnyObject) {
        saveUser()
        showAlert()
        
    }
    
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            xingming.text = user["uname"] as? String
            dianhua.text = user["mobile"] as? String
            dizhi.text = user["email"] as? String
            youxiang.text = user["address"] as? String
        }
    }
    func showAlert() {
        var alert =
            UIAlertView(title:"提示",message:"添加联系人成功",delegate:self,
                        cancelButtonTitle:"确定" )
        alert.alertViewStyle = UIAlertViewStyle.Default
        alert.show()
        
    }
    //保存数据到SQLite
    func saveUser() {
        
        let xingming = self.xingming.text!
        let dianhua = self.dianhua.text!
        let dizhi = self.dizhi.text!
        let youxiang = self.youxiang.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into user(uname,mobile,email,address) values('\(xingming)','\(dianhua)','\(dizhi)','\(youxiang)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
