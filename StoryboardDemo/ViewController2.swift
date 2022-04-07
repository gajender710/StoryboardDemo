//
//  ViewController2.swift
//  StoryboardDemo
//
//  Created by Gajender Jangir on 04/04/22.
//

import UIKit

class ViewController2: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredData:[Movie]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filteredData=movies
        searchBar.delegate=self
        collectionView.dataSource=self
        collectionView.delegate=self
    
        collectionView.collectionViewLayout=UICollectionViewFlowLayout()
        

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData=[]
        
        if searchText==""
        {
            filteredData=movies
        }
        else
        {
            for m in movies{
                if m.title.lowercased().contains(searchText.lowercased()){
                    filteredData.append(m)
                }
            }

        }
        self.collectionView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController2:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
    
    cell.setup(with: filteredData[indexPath.row])
    return cell
}
}

extension ViewController2:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 300)
    }
}

