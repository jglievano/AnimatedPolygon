import UIKit

class PolygonView: UIView {

  public var fillPct: CGFloat = 1.0 // Percentage of triangle being drawn

  private var shape = CAShapeLayer()

  func setup() {
    self.shape = CAShapeLayer()
    self.layer.addSublayer(shape)
    shape.opacity = 1
    shape.lineWidth = 1
    shape.lineJoin = kCALineJoinMiter
    shape.strokeColor = UIColor.black.cgColor
    shape.fillColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0).cgColor
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  override func draw(_ rect: CGRect) {
    let height = self.frame.size.height // Height of the view
    let width = self.frame.size.width // Width of the view

    // Some trigonometry, all need to be know is it calculates the half angle from the bottom part
    // of the triangle so we can calculate what should be the length of the sides of the triangle.
    let angle = atan((width / 2) / (height / 2))

    let path = UIBezierPath()
    let y = fillPct * height * 0.5
    let x = y * tan(angle)
    path.move(to: CGPoint(x: width / 2, y: height / 2)) // Place to start drawing. width is divided by
                                                    // 2 because we want it centered.
                                                    // height is already divided by 2.
    path.addLine(to: CGPoint(x: width / 2 - x, y: 0 + (height / 2 - y))) // We draw a line to the top left corner
    path.addLine(to: CGPoint(x: width / 2 + x, y: 0 + (height / 2 - y))) // And another to the top right corner.
    path.close() // Finally, we close to create a triangle shape.

    shape.path = path.cgPath
  }

}
