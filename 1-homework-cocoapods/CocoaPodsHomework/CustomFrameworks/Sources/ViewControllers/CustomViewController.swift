// created by Il'ya G. 21/12/2022
import UIKit

open class CustomViewController: UIViewController {
    override open func loadView() {
        view = CustomUIView()
        view.backgroundColor = .yellow
    }
}
