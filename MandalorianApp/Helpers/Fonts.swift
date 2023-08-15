import UIKit

enum AppFont: String {
    case ralewayBold = "Raleway-Bold"
    case ralewayMedium = "Raleway-Medium"
    case ralewayRegular = "Raleway-Regular"
    case ralewaySemiBold = "Raleway-SemiBold"
    case trispaceBold = "Trispace-Bold"
    case trispaceMedium = "Trispace-Medium"
    case trispaceRegular = "Trispace-Regular"
    case spaceMonoRegular = "SpaceMono-Regular"

    func withSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
