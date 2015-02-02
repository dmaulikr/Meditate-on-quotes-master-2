//
//  View.swift
//  Meditate
//
//  Created by Feliks Leybovich on 1/2/15.
//  Copyright (c) 2015 Koursebook Inc. All rights reserved.
//

import UIKit
import GLKit;	//needed for GLKMathDegreesToRadians

class View: UIView {
    
    
    let label: UILabel = UILabel();
    let labelQuote: UITextView = UITextView();
    let imageView: UIImageView;
    let imageView1: UIImageView;
    let imageView2: UIImageView;
    let imageView3: UIImageView;
    
    required init(coder aDecoder: NSCoder) {
        self.imageView = UIImageView();
        self.imageView1 = UIImageView();
        self.imageView2 = UIImageView();
        self.imageView3 = UIImageView();
        super.init(coder: aDecoder);
        
        // Initialization code
        backgroundColor = UIColor.blackColor();
        
        labelQuote.autoresizingMask =
            UIViewAutoresizing.FlexibleLeftMargin
            | UIViewAutoresizing.FlexibleRightMargin
            | UIViewAutoresizing.FlexibleBottomMargin
            | UIViewAutoresizing.FlexibleWidth;
        
        
        var title: String = "Fate Knows Where You're Going, But It's Up To You To Get There";
        let titlefont: UIFont? = UIFont(name: "Papyrus", size: 30);
        
        //let titlesize: CGSize = title.sizeWithAttributes(titleattributes);
        
        labelQuote.font = titlefont;
        //labelQuote.textAlignment = NSTextAlignment;
        labelQuote.textColor = UIColor.yellowColor();
        labelQuote.text = title;
        labelQuote.backgroundColor = UIColor.blackColor()
        
        
        var image: UIImage? = UIImage(named: "imageLightOn.png");
        if image == nil {
            println("could not open assad.png");
            image = UIImage();	//Make a dummy image because the show must go on.
        }
        
        var image1: UIImage? = UIImage(named: "number-1-design-th.png");
        if image == nil {
            println("number-1-design-th.png");
            image = UIImage();	//Make a dummy image because the show must go on.
        }
        
        var image2: UIImage? = UIImage(named: "number-2-design-th.png");
        if image == nil {
            println("number-2-design-th.png");
            image = UIImage();	//Make a dummy image because the show must go on.
        }
        
        var image3: UIImage? = UIImage(named: "number-3-design-md.png");
        if image == nil {
            println("number-3-design-md.png");
            image = UIImage();	//Make a dummy image because the show must go on.
        }
        
        imageView = UIImageView(image: image!);
        imageView.alpha = 0
        
        imageView1 = UIImageView(image: image1!);
        imageView1.alpha = 0
        
        imageView2 = UIImageView(image: image2!);
        imageView2.alpha = 0
        
        imageView3 = UIImageView(image: image3!);
        imageView3.alpha = 0
        
        //Fade in the lightbulb.
        UIImageView.animateWithDuration(11,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.imageView.alpha = 1;
            },
            
            completion:{(b: Bool) -> Void in
                UIImageView.animateWithDuration(0.5,
                    delay: 0,
                    options: UIViewAnimationOptions.CurveEaseInOut,
                    animations: {
                        self.imageView1.alpha = 1;
                    },
                    completion: {(b: Bool) -> Void in
                        UIImageView.animateWithDuration(0.5,
                            delay: 0,
                            options: UIViewAnimationOptions.CurveEaseInOut,
                            animations: {
                                self.imageView1.alpha = 0;
                            },
                            completion: {(b: Bool) -> Void in
                                UIImageView.animateWithDuration(1,
                                    delay: 0,
                                    options: UIViewAnimationOptions.CurveEaseInOut,
                                    animations: {
                                        self.imageView2.alpha = 1;
                                    },
                                    completion: {(b: Bool) -> Void in
                                        UIImageView.animateWithDuration(0.5,
                                            delay: 0,
                                            options: UIViewAnimationOptions.CurveEaseInOut,
                                            animations: {
                                                self.imageView2.alpha = 0;
                                            },
                                            completion: {(b: Bool) -> Void in
                                                UIImageView.animateWithDuration(0.5,
                                                    delay: 0,
                                                    options: UIViewAnimationOptions.CurveEaseInOut,
                                                    animations: {
                                                        self.imageView3.alpha = 1;
                                                    },
                                                    completion: {(b: Bool) -> Void in
                                                        UIImageView.animateWithDuration(0.5,
                                                            delay: 0,
                                                            options: UIViewAnimationOptions.CurveEaseInOut,
                                                            animations: {
                                                                self.imageView3.alpha = 0;
                                                            },
                                                            completion: nil
                                                        )
                                                    }
                                                )
                                            }
                                        )
                                    }
                                )
                            }
                        )
                    }
                )
            }
        )
        
        
        
        
        
        
        let recognizer: UIRotationGestureRecognizer =
        UIRotationGestureRecognizer(target: self, action: "rotate:");
        
        addGestureRecognizer(recognizer);
        
        addSubview(imageView);
        addSubview(imageView1);
        addSubview(imageView2);
        addSubview(imageView3);
        addSubview(labelQuote);
        
    }
    
    //Center the label below the slider, separated by a margin.
    
    
    
    
    override func layoutSubviews() {
        let m: CGFloat = min(bounds.size.width, bounds.size.height);
        let margin: CGFloat = m / 30;
        println("\(margin)")
        label.frame = CGRectMake(
            frame.origin.x,
            frame.origin.y + frame.size.height + margin,
            frame.size.width,
            frame.size.height);
        
        labelQuote.frame = CGRectMake(
            imageView.frame.origin.x,
            imageView.frame.origin.y + imageView.frame.size.height + margin,
            imageView.frame.size.width,
            imageView.frame.size.height);
        println("\(imageView.frame.size.height)")
        
    }
    
    
    func valueChanged(slider: UISlider!) {
        //As the slider goes from the minimum to the maximum value,
        //red goes from 0 to 1.  Conversely, blue goes from 1 to 0.
        
        let red: CGFloat = CGFloat(slider.value - slider.minimumValue)
            / CGFloat(slider.maximumValue - slider.minimumValue);
        
        label.backgroundColor = UIColor(red: red, green: 0.0, blue: 1.0 - red, alpha: 1.0);
        imageView.alpha = red;
        
        //Each number is at least 5 characters wide, with one digit to right of decimal point.
        label.text = String(format: "Hello");
    }
    
    func rotate(recognizer: UIRotationGestureRecognizer) {
        //Convert CGFloat to Float, because GLKMathRadiansToDegrees demands a Float parameter.
        let radians: Float = Float(recognizer.rotation);
        let degrees: Float = GLKMathRadiansToDegrees(radians);
        println("recognizer.rotation = \(degrees)");	//positive is clockwise
        
        imageView.transform = CGAffineTransformMakeRotation(recognizer.rotation);
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
