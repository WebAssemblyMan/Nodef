//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class SixfoldRotatedTileFX: BaseTileFX {
       
    @Published var centerX:Float = 150
    @Published var centerY:Float = 150
    
    @Published var angle:Float = 0.0
    @Published var width:Float = 100.0
    
    let description = "Produces a tiled image from a source image by rotating the source image at increments of 60 degrees. Width is the width of a tile."
    
    override init()
    {
        let name="CISixfoldRotatedTile"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
        print("inputAngle")
        if let attribute = CIFilter.sixfoldRotatedTile().attributes["inputAngle"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        print("inputWidth")
        if let attribute = CIFilter.sixfoldRotatedTile().attributes["inputWidth"] as? [String: AnyObject]
        {
           let minimum = attribute[kCIAttributeSliderMin] as? Float
           let maximum = attribute[kCIAttributeSliderMax] as? Float
           let defaultValue = attribute[kCIAttributeDefault] as? Float
            
            print(minimum)
            print(maximum)
            print(defaultValue)
            
        }
        */
    }

    enum CodingKeys : String, CodingKey {
        case centerX
        case centerY
        case angle
        case width
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc=description
        

        centerX = try values.decodeIfPresent(Float.self, forKey: .centerX) ?? 0.0
        centerY = try values.decodeIfPresent(Float.self, forKey: .centerY) ?? 0.0

        angle = try values.decodeIfPresent(Float.self, forKey: .angle) ?? 0.0
        width = try values.decodeIfPresent(Float.self, forKey: .width) ?? 0.0

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
  
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(centerX, forKey: .centerX)
        try container.encode(centerY, forKey: .centerY)
        try container.encode(angle, forKey: .angle)
        try container.encode(width, forKey: .width)
  
    }
    
    override func setupProperties(_ parent: FiltersX?)
    {
        super.setupProperties(parent)
        
        if parent != nil{
            centerX=Float(size.width/2.0)
            centerY=Float(size.height/2.0)
        }
        
    }
    
    override func adjustPropertiesToBounds(_ parent: FiltersX?)
    {
        super.adjustPropertiesToBounds(parent)
        
        centerX = centerX > Float(size.width) ? Float(size.width) : centerX
        centerY = centerY > Float(size.height) ? Float(size.height) : centerY
        
    }
    
    var sixfoldRotatedTileCIFilter:CIFilter?
    //deprecate
    override func getCIFilter(currentImage: CIImage, beginImage: CIImage) -> CIFilter? {
        
        var sixfoldRotatedTileFilter: CIFilter

        sixfoldRotatedTileFilter = sixfoldRotatedTileCIFilter != nil ? sixfoldRotatedTileCIFilter! : CIFilter(name: type)!
        
        let inputImage=handleAlias(alias: inputImageAlias,
                                      inputImage: currentImage,
                                      beginImage: beginImage)
        
        sixfoldRotatedTileFilter.setValue(inputImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        sixfoldRotatedTileFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        sixfoldRotatedTileFilter.setValue(angle, forKey: kCIInputAngleKey)
        sixfoldRotatedTileFilter.setValue(width, forKey: kCIInputWidthKey)

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: sixfoldRotatedTileFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=sixfoldRotatedTileFilter
            return ciFilter!
        }
        
    }
    //ANCHISES
    override func getCIFilter(_ ciImage: CIImage)->CIFilter
    {
 
        var sixfoldRotatedTileFilter: CIFilter
        if sixfoldRotatedTileCIFilter != nil {
            sixfoldRotatedTileFilter = sixfoldRotatedTileCIFilter!
        } else {
            sixfoldRotatedTileFilter = CIFilter(name: type)!
            sixfoldRotatedTileCIFilter=sixfoldRotatedTileFilter
     
        }
        
        sixfoldRotatedTileFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let tcenter=CIVector(x:CGFloat(centerX),y:CGFloat(centerY))
        sixfoldRotatedTileFilter.setValue(tcenter, forKey: kCIInputCenterKey)
        sixfoldRotatedTileFilter.setValue(angle, forKey: kCIInputAngleKey)
        sixfoldRotatedTileFilter.setValue(width, forKey: kCIInputWidthKey)

        if cropToFormat{
            super.setCIFilterAndCropImage(inputImage: sixfoldRotatedTileFilter.outputImage!)
            return ciFilter!
        }
        else{
            ciFilter=sixfoldRotatedTileFilter
            return ciFilter!
        }
    }

}
