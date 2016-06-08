//
//  ViewController.swift
//  TomCatSwift
//
//  Created by jiaoguifeng on 6/7/16.
//  Copyright © 2016 Tricheer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //定义变量，包括@IBOutlet
    @IBOutlet var imageViewCat: UIImageView!
    var picCounts: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //初始化变量可以放在viewdidload或者init中
        let path: String = NSBundle.mainBundle().pathForResource("tom", ofType: "plist")!
        picCounts = NSDictionary.init(contentsOfFile: path)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     Action method
     */
    @IBAction func cymbal() {
        animationStartName("cymbal")
    }

    @IBAction func eat() {
        animationStartName("eat")
    }

    @IBAction func drink() {
        animationStartName("drink")
    }

    @IBAction func pie() {
        animationStartName("pie")
    }

    @IBAction func scratch() {
        animationStartName("scratch")
    }

    @IBAction func knockout() {
        animationStartName("knockout")
    }

    @IBAction func stomach() {
        animationStartName("stomach")
    }

    @IBAction func foot_left() {
        animationStartName("foot_left")
    }

    @IBAction func foot_right() {
        animationStartName("foot_right")
    }

    @IBAction func angry() {
        animationStartName("angry")
    }

    @IBAction func fart() {
        animationStartName("fart")
    }

    /**
     *  base method
     */
    func animationStartName(name: String) -> Void {
        
        let isAnimation: Bool = self.imageViewCat!.isAnimating()
        if isAnimation {
            self.imageViewCat.stopAnimating()
            self.imageViewCat.animationImages = nil
        }

        let picCount: Int = picCounts![name]!.integerValue
        var arrayM: [UIImage]! = []
        
        for i in 0 ..< picCount {
            let path: String = NSBundle.mainBundle().pathForResource(name + "_" + String(format:"%02i",Int(i)), ofType: "jpg")!
            let image: UIImage = UIImage.init(contentsOfFile: path)!
            arrayM.append(image)
        }
        
        self.imageViewCat.animationImages = arrayM
        self.imageViewCat.animationDuration = Double((self.imageViewCat?.animationImages?.count)!) * 0.1
        self.imageViewCat.animationRepeatCount = 1
        self.imageViewCat.startAnimating()
        self.imageViewCat.performSelector(Selector("setAnimationImages:"), withObject: nil, afterDelay: Double((self.imageViewCat?.animationImages?.count)!) * 0.1)
    }
}

