//
//  Copyright © 2022 James Boo. All rights reserved.
//

import SwiftUI

class ScreenBlendModeFX: BaseBlendFX {
       
    let description = "Multiplies the inverse of the input image (A) samples with the inverse of the background image (B) samples. This results in colors that are at least as light as either of the two contributing sample colors. "
    override init()
    {
        let name = "CIScreenBlendMode"
        super.init(name)
        desc=description
        /*
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedName(forFilterName: name))
        print(CIFilter.localizedDescription(forFilterName: name))
        print(CIFilter.localizedReferenceDocumentation(forFilterName: name))
         */
    }

    enum CodingKeys : String, CodingKey {
        case None
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        desc=description

    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
