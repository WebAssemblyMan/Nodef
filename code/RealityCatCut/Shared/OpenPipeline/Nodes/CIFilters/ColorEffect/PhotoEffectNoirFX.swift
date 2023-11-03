//
//  Copyright © 2022 James Boo. All rights reserved.
//
import SwiftUI

class PhotoEffectNoirFX: FilterX {
       

    let description = "Applies a preconfigured set of effects that imitate black-and-white photography film with exaggerated contrast."

    override init()
    {
        let name = "CIPhotoEffectNoir"
        super.init(name)
        desc=description
        /*
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
