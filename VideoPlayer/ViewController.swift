//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Ильяяя on 28.05.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var dataSource: [VideoItem] = []
    private var tableViewVideos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        setupUI()
    }


    //MARK: - Setup UI
    private func setupUI() {
        navigationItem.title = "Watch List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        navigationController?.navigationBar.barTintColor = UIColor(red: 120/255, green: 118/255, blue: 99/255, alpha: 1)
//        navigationController?.navigationBar.backgroundColor = UIColor(red: 120/255, green: 118/255, blue: 99/255, alpha: 1)
        
        tableViewVideos = UITableView()
        view.addSubview(tableViewVideos)
        tableViewVideos.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableViewVideos.dataSource = self
        tableViewVideos.delegate = self
        tableViewVideos.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    private func initData() {
        dataSource.append( VideoItem(title: "Matrix", desc: "1999", screen: "matrixscreen", file: "matrix.mp4") )
        dataSource.append( VideoItem(title: "Interstellar", desc: "2014", screen: "interstellarscreen", file: "interstellar.mp4") )
        dataSource.append( VideoItem(title: "Trainspotting", desc: "1996", screen: "trainspottingscreen", file: "trainspotting.mp4") )
        dataSource.append( VideoItem(title: "Matrix", desc: "1999", screen: "matrixscreen", file: "matrix.mp4") )
        dataSource.append( VideoItem(title: "Interstellar", desc: "2014", screen: "interstellarscreen", file: "interstellar.mp4") )
        dataSource.append( VideoItem(title: "Trainspotting", desc: "1996", screen: "trainspottingscreen", file: "trainspotting.mp4") )
        dataSource.append( VideoItem(title: "Matrix", desc: "1999", screen: "matrixscreen", file: "matrix.mp4") )
        dataSource.append( VideoItem(title: "Interstellar", desc: "2014", screen: "interstellarscreen", file: "interstellar.mp4") )
        dataSource.append( VideoItem(title: "Trainspotting", desc: "1996", screen: "trainspottingscreen", file: "trainspotting.mp4") )
    }
}

//MARK: - Data Source Protocol
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tableViewVideos:
            return dataSource.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case self.tableViewVideos:
            let cell = tableViewVideos.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.setup(data: dataSource[indexPath.row])
            
            return cell
        default:
            // Fetch a cell of the appropriate type.
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
            
            // Configure the cell’s contents.
            cell.textLabel!.text = "Cell text"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
//        var selectedCell = tableView.cellForRow(at: indexPath) as! TableViewCell
////        selectedCell.contentView.backgroundColor = UIColor.redColor()
//        selectedCell.sc
//    }
//
//    // if tableView is set in attribute inspector with selection to multiple Selection it should work.
//
//    // Just set it back in deselect
//
//    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        var cellToDeSelect:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
//        cellToDeSelect.contentView.backgroundColor = colorForCellUnselected
//    }
}

