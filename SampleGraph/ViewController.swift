//
//  ViewController.swift
//  SampleGraph
//
//  Created by Nekokichi on 2020/10/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let graphview = LineGraph() //グラフを表示するクラス
        self.view.addSubview(graphview) //グラフをスクロールビューに配置
        graphview.drawLineGraph() //グラフ描画開始
    }


}

