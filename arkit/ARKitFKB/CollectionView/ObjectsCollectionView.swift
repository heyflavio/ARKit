//
//  ObjectsCollectionView.swift
//  ARKitFKB
//
//  Created by iMac on 03/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

// MARK: - VirtualObjectSelectionViewControllerDelegate

protocol VirtualObjectSelectionDelegate: class {
    func virtualObjectSelectionDelegate(_: ObjectsCollectionView, didSelectObjectAt index: Int)
    func virtualObjectSelectionDelegate(_: ObjectsCollectionView, didDeselectObjectAt index: Int)
}

class ObjectsCollectionView: UIView {
    
    let reuseIdentifier = "objectsCell"
    private var selectedVirtualObjectRows = IndexSet()
    weak var delegate: VirtualObjectSelectionDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var objects: [VirtualObjectDefinition] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ObjectsCollectionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.estimatedItemSize = CGSize(width: 140.0, height: 140.0)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
    }
    
}

extension ObjectsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.virtualObjectSelectionDelegate(self, didSelectObjectAt: indexPath.row)
//        if selectedVirtualObjectRows.contains(indexPath.row) {
//            delegate?.virtualObjectSelectionDelegate(self, didDeselectObjectAt: indexPath.row)
//        } else {
//            
//        }
    }
}

extension ObjectsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .red
        
        let object = objects[indexPath.row]
        //cell.title = object.displayName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
    
}
