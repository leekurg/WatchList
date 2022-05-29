//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Ильяяя on 28.05.2022.
//

import UIKit
import SnapKit
import AVKit

class ViewController: UIViewController, UITableViewDelegate {

    private var dataSource: [VideoItem] = []
    private var tableViewVideos: UITableView!
    private var playViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        setupUI()
    }


    //MARK: - Setup UI
    private func setupUI() {
        navigationItem.title = "Watch List"
        navigationController?.navigationBar.prefersLargeTitles = true

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
extension ViewController: UITableViewDataSource {
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
            
            cell.delegate = self
            cell.buttonPlay?.tag = indexPath.row
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellTypeIdentifier", for: indexPath)
            cell.textLabel!.text = "Undefined cell text"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//MARK: - Cell Delegate
protocol ViewControllerCellDelegate : AnyObject {
    func didPressButton(_ tag: Int)
}

//MARK: - Video Playing
extension ViewController: ViewControllerCellDelegate {
    func didPressButton(_ tag: Int) {
        if tag < 0 || tag >= dataSource.count { return }

        let nametype = dataSource[tag].file.split(separator: ".")
        
        guard let path = Bundle.main.path(forResource: String(nametype[0]), ofType: String(nametype[1])) else {
            let alert = UIAlertController(title: "", message: "❗️Video \"\(dataSource[tag].file)\" not found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
            
                    return
                }
        
        playViewController.player = AVPlayer(url: URL(fileURLWithPath: path))
        
        self.present(playViewController, animated: true) {
            self.playViewController.player?.play()
        }
    }
}
