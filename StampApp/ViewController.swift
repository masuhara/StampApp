//
//  ViewController.swift
//  StampApp
//
//  Created by Masuhara on 2018/08/05.
//  Copyright © 2018年 Ylab, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var baseImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseImageView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UIImagePickerController Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        baseImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // Private
    @IBAction func selectImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func stamp1() {
        // ラベルスタンプの生成
        let labelStamp = UILabel()
        // ラベルの大きさと位置を決める
        labelStamp.frame.size = CGSize(width: 120, height: 20)
        labelStamp.center = baseImageView.center
        
        // ラベルへのタッチ検出を許可する
        labelStamp.isUserInteractionEnabled = true
        
        // ラベルスタンプを移動できるようにジェスチャーを登録
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesture(panGestureRecognizer:)))
        labelStamp.addGestureRecognizer(panGestureRecognizer)
        
        // 文字
        labelStamp.text = "#2018 Summer"
        labelStamp.textColor = UIColor.white
        
        // ImageViewに貼り付け
        baseImageView.addSubview(labelStamp)
    }
    
    @IBAction func stamp2() {
        // 画像スタンプの生成
        let imageStamp = UIImageView()
        
        // 画像の大きさと位置を決める
        imageStamp.frame.size = CGSize(width: 80, height: 80)
        imageStamp.center = baseImageView.center
        
        // 画像へのタッチ検出を許可する
        imageStamp.isUserInteractionEnabled = true
        
        // 画像スタンプを移動できるようにジェスチャーを登録
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesture(panGestureRecognizer:)))
        imageStamp.addGestureRecognizer(panGestureRecognizer)
        
        // 画像を決める
        imageStamp.image = UIImage(named: "shy_smile.png")
        
        // ImageViewに貼り付け
        baseImageView.addSubview(imageStamp)
    }
    
    @IBAction func save() {
        // ラベルなど画像をすべて1枚に合成
        UIGraphicsBeginImageContextWithOptions(baseImageView.frame.size, false, 2.0)
        baseImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 保存
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        // 保存完了のアラート
        let alert = UIAlertController(title: "保存完了", message: "写真の保存が完了しました。", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Gesture
    @objc func panGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let location = panGestureRecognizer.location(in: baseImageView)
        panGestureRecognizer.view?.center = location
    }

}

