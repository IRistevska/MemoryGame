import UIKit

@IBDesignable

class GradientColor: UIView {
    
    @IBInspectable var firsColor:UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    @IBInspectable var secondColor:UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    @IBInspectable var thirdColor:UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    
    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    func updateView(){
        if let gradientLayer = self.layer as? CAGradientLayer {
            gradientLayer.colors = [firsColor.cgColor,secondColor.cgColor,thirdColor.cgColor]
            gradientLayer.frame.size.width = self.frame.size.width
            gradientLayer.frame.size.height = self.frame.size.height
            gradientLayer.frame.size.height = self.frame.size.height
            gradientLayer.startPoint = CGPoint(x: 0.3, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.3)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.3)
           
            
            
            
            
            
        }
        
    }
    
}
