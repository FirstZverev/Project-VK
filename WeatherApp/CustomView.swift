//
//  CustomView.swift
//  WeatherApp
//
//  Created by Володя Зверев on 12.02.2019.
//  Copyright © 2019 Володя Зверев. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
    
}
class ViewModel2: BaseViewModel {
    
} 
class WeatherViewModel: BaseViewModel {
    var temp: String = ""
    var date: String = ""
    var weatherIconName: String = ""
    
    init(temp: String, date: String) {
        self.temp = temp
        self.date = date
    }
}

class WeatherHeaderViewModel {
    var cityName = "City"
}

enum CellIdentifier: String {
    case defaultCell = "UITableViewCell"
    case weatherTableViewCell = "WeatherTableViewCell"
    case viewModel2 = "viewModel2"
}


class CustomView: UIView {
    
    public func reload(viewModels: [BaseViewModel]) {
        self.viewModels = viewModels
        self.tableView?.reloadData()
        self.collectionView?.reloadData()
    }
    
    // MARK: -
    
    private var viewModels: [BaseViewModel] = []
    
    private weak var tableView: UITableView?
    
    private weak var collectionView: UICollectionView?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    private func customInit() {
        self.addSubviews()
    }
    
    // MARK: - Subview
    
    func addSubviews() {
        //self.addTableView()
        self.addCollectionView()
    }
    
    func addCollectionView() {
        
        //let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: CollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        let weatherNib = UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
        collectionView.register(weatherNib, forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        
        self.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func addTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        self.tableView = tableView
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.defaultCell.rawValue)
        
        tableView.register(TableViewCell2.self, forCellReuseIdentifier: CellIdentifier.viewModel2.rawValue)
        
        let weatherNib = UINib(nibName: "WeatherTableViewCell", bundle: nil)
        tableView.register(weatherNib, forCellReuseIdentifier: CellIdentifier.weatherTableViewCell.rawValue)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tableView?.frame = self.bounds
        self.collectionView?.frame = self.bounds
    }
}

extension CustomView: UICollectionViewDelegate {
    
}

extension CustomView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let viewModel = self.viewModels[indexPath.row] as? WeatherViewModel, let weatherCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as? WeatherCollectionViewCell {
            
            weatherCell.setViewModel(viewModel: viewModel)
            return weatherCell
            
        }
        
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        defaultCell.backgroundColor = UIColor.red
        
        return defaultCell
    }
}

extension CustomView: UITableViewDelegate {
    
}

extension CustomView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let viewModel = self.viewModels[indexPath.row] as? WeatherViewModel, let weatherCell =
            tableView.dequeueReusableCell(withIdentifier: CellIdentifier.weatherTableViewCell.rawValue, for: indexPath) as? WeatherTableViewCell {
            
            weatherCell.setViewModel(viewModel: viewModel)
            return weatherCell
            
        } else if let viewModel = self.viewModels[indexPath.row] as? ViewModel2, let cell2 = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.viewModel2.rawValue, for: indexPath) as? TableViewCell2 {
            
            return cell2
            
        } else {
            
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.defaultCell.rawValue, for: indexPath)
            defaultCell.textLabel?.text = "\(indexPath)"
            defaultCell.textLabel?.textColor = UIColor.black
            return defaultCell
            
        }
    }
}
