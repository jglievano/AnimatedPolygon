import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var drawView: PolygonView!

  var timer:Timer?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let t = self.timer {
      t.invalidate()
    }
    timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { (timer) in
      self.drawView.fillPct -= 0.001
    })
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.timer?.invalidate()
    self.timer = nil
  }

}
