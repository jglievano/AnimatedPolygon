import UIKit

class PolygonView: UIView {

  // Percentage of triangle being drawn
  public var fillPct: CGFloat = 1.0 {
    didSet {
      if fillPct < 0 {
        fillPct = 0 // Minimum fillPct is 0
      }
      self.setNeedsDisplay()
    }
  }

  private var topShape = CAShapeLayer()
  private var bottomShape = CAShapeLayer()

  public func setFillColor(color: UIColor) {
    topShape.fillColor = color.cgColor
    bottomShape.fillColor = color.cgColor
  }

  private func setup() {
    topShape = CAShapeLayer()
    layer.addSublayer(topShape)
    topShape.opacity = 1
    topShape.lineWidth = 1
    topShape.lineJoin = kCALineJoinMiter
    topShape.strokeColor = UIColor.black.cgColor

    bottomShape = CAShapeLayer()
    layer.addSublayer(bottomShape)
    bottomShape.opacity = 1
    bottomShape.lineWidth = 1
    bottomShape.lineJoin  = kCALineJoinMiter
    bottomShape.strokeColor = UIColor.black.cgColor

    setFillColor(color: UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 1.0))
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
    let height = frame.size.height // Height of the view
    let width = frame.size.width // Width of the view

    // Some trigonometry, all need to be know is it calculates the half angle from the bottom part
    // of the triangle so we can calculate what should be the length of the sides of the triangle.
    let angle = atan((width / 2) / (height / 2))

    let topPath = UIBezierPath()
    let y = fillPct * height * 0.5
    let x = y * tan(angle)
    topPath.move(to: CGPoint(x: width / 2, y: height / 2)) // Place to start drawing. width is divided by
                                                    // 2 because we want it centered.
                                                    // height is already divided by 2.
    topPath.addLine(to: CGPoint(x: width / 2 - x, y: height / 2 - y)) // We draw a line to the top left corner
    topPath.addLine(to: CGPoint(x: width / 2 + x, y: height / 2 - y)) // And another to the top right corner.
    topPath.close() // Finally, we close to create a triangle shape.

    topShape.path = topPath.cgPath

    let topAngle = (90 * CGFloat.pi / 180) - angle // the * PI / 180 is because we manage radians
    let missingY = height * 0.5 - y // y fill of bottom part is unfill of top part
    let missingX = missingY / atan(topAngle)
    if missingX > width / 2 {
      return
    }
    let bottomPath = UIBezierPath()
    bottomPath.move(to: CGPoint(x: 0, y: height))
    bottomPath.addLine(to: CGPoint(x: missingX, y: height - missingY))
    bottomPath.addLine(to: CGPoint(x: width - missingX, y: height - missingY))
    bottomPath.addLine(to: CGPoint(x: width, y: height))
    bottomPath.close()

    bottomShape.path = bottomPath.cgPath
  }

}
