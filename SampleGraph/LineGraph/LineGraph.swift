//
//  LineGraph.swift
//  SampleGraph
//
//  Created by Nekokichi on 2020/10/31.
//

import UIKit

class LineGraph: UIView {

    var lineWidth:CGFloat = 3.0 //グラフ線の太さ
    var lineColor:UIColor = UIColor(red:0.088,  green:0.501,  blue:0.979, alpha:1) //グラフ線の色
//    var circleWidth:CGFloat = 4.0 //点の半径
//    var circleColor:UIColor = UIColor(red:0.088,  green:0.501,  blue:0.979, alpha:1) //点の色

    var memoriMargin: CGFloat = 70 //横目盛の感覚
    var graphHeight: CGFloat = 300 //グラフの高さ
    var graphPoints: [String] = [] //グラフの横目盛り
    var graphDatas: [CGFloat] = [] //グラフの値

    func drawLineGraph()
    {
        graphPoints = ["2000/2/3", "2000/3/3", "2000/4/3", "2000/5/3", "2000/6/3", "2000/7/3", "2000/8/3"]
        graphDatas = [100, 30, 10, -50, 90, 12, 40]

        GraphFrame()
        MemoriGraphDraw()
    }

    //グラフを描画するviewの大きさ
    func GraphFrame(){
        self.backgroundColor = UIColor(red:0.972,  green:0.973,  blue:0.972, alpha:1)
        self.frame = CGRect(x: 10 , y: 0, width: checkWidth(), height: checkHeight())
    }

    //横目盛・グラフを描画する
    func MemoriGraphDraw() {

        var count:CGFloat = 0
        for memori in graphPoints {
            //ラベル作成〜設定
            let label = UILabel()
            label.text = String(memori)
            label.font = UIFont.systemFont(ofSize: 9)

            //ラベルの位置情報
            //ラベルのサイズを取得
            let frame = CGSize(width: 250, height: CGFloat.greatestFiniteMagnitude)
            let rect = label.sizeThatFits(frame)

            //ラベルの位置
            var lebelX = (count * memoriMargin)-rect.width/2
            //最初のラベル
            if Int(count) == 0{
                lebelX = (count * memoriMargin)
            }
            //最後のラベル
            if Int(count+1) == graphPoints.count{
                lebelX = (count * memoriMargin)-rect.width
            }

            //ラベルを描画
            label.frame = CGRect(x: lebelX , y: graphHeight, width: rect.width, height: rect.height)
            self.addSubview(label)

            count += 1
        }
    }

    // graphDatasの最大値-最低値
    var yAxisMax: CGFloat {
        return graphDatas.max()!-graphDatas.min()!
    }

    //グラフ横幅を算出
    func checkWidth() -> CGFloat{
        return CGFloat(graphPoints.count-1) * memoriMargin
    }

    //グラフ縦幅を算出
    func checkHeight() -> CGFloat{
        return graphHeight
    }

    //グラフの線を描画
    override func draw(_ rect: CGRect) {
        var count:CGFloat = 0
        let linePath = UIBezierPath() //線
//        var myCircle = UIBezierPath() //点

        linePath.lineWidth = lineWidth //線の幅
        lineColor.setStroke() //UIBezierPathに色を適用？

        //datapoint:各点の値
        //move -> addLine -> addLine -> ... -> linePath.stroke()
        for datapoint in graphDatas {
            //count+1がgraphDatas.countを超えるまでループ
            if Int(count+1) < graphDatas.count {

                //終点(2回目以降のループ)
                var nextY: CGFloat = 0
                //(値 / （最大値ー最小値）* (グラフの高さ))
                nextY = graphDatas[Int(count+1)]/yAxisMax * (graphHeight)
                //グラフの高さー nextY
                nextY = graphHeight - nextY
                if(graphDatas.min()!<0){
                    nextY = (graphDatas[Int(count+1)] - graphDatas.min()!)/yAxisMax * (graphHeight)
                    nextY = graphHeight - nextY
                }

                //最初の開始地点を指定（1回目のループ）
                //count==0の時、count>0はnowYを採用？
                var circlePoint:CGPoint = CGPoint()
                //始点(値 / （最大値ー最小値）* (グラフの高さー点の半径))
                var nowY: CGFloat = datapoint/yAxisMax * (graphHeight)
                nowY = graphHeight - nowY
                //graphDatasの最小値がマイナスの場合
                if(graphDatas.min()!<0){
                    nowY = (datapoint - graphDatas.min()!)/yAxisMax * (graphHeight)
                    nowY = graphHeight - nowY
                }
                //最初のループ時にのみ発動
                if Int(count) == 0 {
                    //yが増加すると、開始地点が低くなる
                    linePath.move(to: CGPoint(x: 0, y: nowY))
//                    circlePoint = CGPoint(x: count * memoriMargin + circleWidth, y: nowY)
//                    myCircle = UIBezierPath(arcCenter: circlePoint,radius: circleWidth,startAngle: 0.0,endAngle: CGFloat(M_PI*2),clockwise: false)
//                    circleColor.setFill()
//                    myCircle.fill()
//                    myCircle.stroke()
                }

                //描画ポイントを指定
                //原点からx座標を計算
                linePath.addLine(to: CGPoint(x: (count+1) * memoriMargin, y: nextY))

                //円をつくる
//                circlePoint = CGPoint(x: (count+1) * memoriMargin, y: nextY)
//                myCircle = UIBezierPath(arcCenter: circlePoint,
//                    // 半径
//                    radius: circleWidth,
//                    // 初角度
//                    startAngle: 0.0,
//                    // 最終角度
//                    endAngle: CGFloat(M_PI*2),
//                    // 反時計回り
//                    clockwise: false)
//                circleColor.setFill()
//                myCircle.fill()
//                myCircle.stroke()
            }
            count += 1
        }
        //折れ線グラフを描画
        /*
         <UIBezierPath: 0x6000030c2ee0;
          <MoveTo {4, 4}>,
          <LineTo {70, 138.13333333333333}>,
          <LineTo {140, 177.59999999999999}>,
          <LineTo {210, 296}>,
          <LineTo {280, 19.733333333333348}>,
          <LineTo {350, 173.65333333333334}>,
          <LineTo {420, 118.40000000000001}>
         */
        print(linePath)
        linePath.stroke()
    }


}
