//
//  ShoppingListTableViewController.swift
//  SeSAC_03_Mylog
//
//  Created by mac on 2021/10/13.
//

import UIKit
import RealmSwift



class ShoppingListTableViewController: UITableViewController {

    var tasks:Results<ShoppingList>!
    
    let localRealm = try! Realm()
 
    
    @IBOutlet weak var IsUserInputTf: UITextField!
    
    @IBOutlet var listTableView: UITableView!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let BtnImg = UIImage(systemName:"square.grid.2x2.fill")
        let filterBtn = UIBarButtonItem(image:BtnImg, style:.plain, target: self, action: #selector(filterBtn(_:)))
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = filterBtn

        self.tabBarController?.tabBar.tintColor = UIColor.green
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.white
        
        self.IsUserInputTf.placeholder = "무엇을 구매하실 건가요?"
        print("Realm:",localRealm.configuration.fileURL!)
        tasks = localRealm.objects(ShoppingList.self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        listTableView.reloadData()
    }
    
 
    


    
    
    

//    func loadData(){
//        let userD = UserDefaults.standard
//
//        var shopdata = [shoppingList]()
//
//        if let data = userD.object(forKey: "shopListCell") as? [[String:Any]]{
//            for datum in data {
//                guard let content = datum["checkList"] as? String else {return}
//                shopdata.append(shoppingList(checkList: content))
//            }
//        }
//    }
//
//
//
//    func saveData(){
//        var shopdata:[[String:Any]] = []
//
//
//        for i in dataArry {
//            let data: [String:Any] = [
//                "checkList":i.checkList
//            ]
//            shopdata.append(data)
//    }
//        let userD = UserDefaults.standard
//        userD.set(shopdata, forKey: "shopListCell")
//
//        tableView.reloadData()
//
//    }
//
  
 



override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return tasks.count
}


override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingList", for: indexPath) as! ShoppingListTableViewCell
    
    let row = tasks[indexPath.row]
    
    cell.dataLabel.text = row.title
    cell.checkboxBtn.tag = indexPath.row
    cell.bookmarkBtn.tag = indexPath.row
    
    cell.checkboxBtn.addTarget(self, action: #selector(isClickedCheckboxBtn(selected:)), for: .touchUpInside)
    cell.bookmarkBtn.addTarget(self, action: #selector(isClickedBookmarkBtn(selected:)), for: .touchUpInside)
    
    return cell
}


override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    52
}

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    try! localRealm.write{
        localRealm.delete(tasks[indexPath.row])
        tableView.reloadData()
    }
    }
    
@IBAction func AddCellBtn(_ sender: UIButton) {

    let task = ShoppingList(title:IsUserInputTf.text!)
    
    try! localRealm.write{
        localRealm.add(task)
    }
    
    listTableView.reloadData()
  
}

 @objc func isClickedBookmarkBtn(selected: UIButton){
     
     print("bookmark")
     let taskToUpdate = tasks[selected.tag]
               try! localRealm.write {
                   taskToUpdate.bookmark = (taskToUpdate.bookmark + 1) % 2
               }
               listTableView.reloadData()
    }
    
 @objc func isClickedCheckboxBtn(selected: UIButton){
     
     print("check")
           let taskToUpdate = tasks[selected.tag]
                  try! localRealm.write {
                      taskToUpdate.check = (taskToUpdate.check + 1) % 2
                  }
                  listTableView.reloadData()
       }
    
    @objc func filterBtn(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "CATEGORY", message: "분류 선택", preferredStyle: .actionSheet)
       
        let success = UIAlertAction(title: "완료순", style: .default){ action
            in
            let sortedByCheck = self.tasks.sorted(byKeyPath: "check", ascending: false)
            self.tasks = sortedByCheck
           
            self.listTableView.reloadData()
        }
        let check = UIAlertAction(title: "이름순", style: .default){ action
            in
            let sortedBytitle = self.tasks.sorted(byKeyPath: "title", ascending: false)
            self.tasks = sortedBytitle
            
            self.listTableView.reloadData()
        }
        let bookmark = UIAlertAction(title: "즐겨찾기순", style: .default){ action
            in
            let sortedBybookmark = self.tasks.sorted(byKeyPath: "bookmark", ascending: false)
            self.tasks = sortedBybookmark
            
            self.listTableView.reloadData()
        }
      
        
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(success)
        alert.addAction(check)
        alert.addAction(bookmark)
        alert.addAction(actionCancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    

}

