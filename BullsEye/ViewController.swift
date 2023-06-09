//
//  ViewController.swift
//  BullsEye
//
//  Created by Kadirhan Keles on 8.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    var label1: UILabel?
    var label2: UILabel?
    var label3: UILabel?
    var label4: UILabel?
    var label5: UILabel?
    var label6: UILabel?
    var label7: UILabel?
    var label8: UILabel?
    
    lazy var addButton: UIButton = {
        
        let button = UIButton (type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hit Me!", for: .normal)
        let image = UIImage(named: "Button-Highlighted")
        let backgroundImage = image?.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), resizingMode: .stretch)
        button.setBackgroundImage(backgroundImage, for: .normal)
        return button
    }()
    
    lazy var mySlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        // slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var overButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton (configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "StartOverIcon"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var infoButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let button = UIButton (configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "InfoButton"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    func createStackView(with axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewRound()
        setupViews()
    }
    
    func setupViews() {
        let backgroundImage = UIImage(named: "Background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0)
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        mySlider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        mySlider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        mySlider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        mySlider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        label1 = createLabel(text: "Put the Bull's Eye as close as you can to: ")
        label2 = createLabel(text: "\(targetValue)")
        label3 = createLabel(text: "1")
        label4 = createLabel(text: "100")
        label5 = createLabel(text: "Score: ")
        label6 = createLabel(text: "0")
        label7 = createLabel(text: "Round: ")
        label8 = createLabel(text: "1")
        
        let verticalStackView = createStackView(with: .vertical)
        let h1StackView = createStackView(with: .horizontal)
        let h2StackView = createStackView(with: .horizontal)
        let h3StackView = createStackView(with: .horizontal)
        
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(h1StackView)
        h1StackView.addArrangedSubview(label1!)
        h1StackView.addArrangedSubview(label2!)
        verticalStackView.setCustomSpacing(30, after: h1StackView)
        verticalStackView.addArrangedSubview(h2StackView)
        h2StackView.addArrangedSubview(label3!)
        h2StackView.addArrangedSubview(mySlider)
        h2StackView.addArrangedSubview(label4!)
        verticalStackView.setCustomSpacing(70, after: h2StackView)
        verticalStackView.addArrangedSubview(addButton)
        verticalStackView.addArrangedSubview(h3StackView)
        verticalStackView.setCustomSpacing(110, after: addButton)
        h3StackView.addArrangedSubview(overButton)
        h3StackView.setCustomSpacing(UIScreen.main.bounds.width * 0.15, after: overButton)
        h3StackView.addArrangedSubview(label5!)
        h3StackView.addArrangedSubview(label6!)
        h3StackView.setCustomSpacing(UIScreen.main.bounds.width * 0.15, after: label6!)
        h3StackView.addArrangedSubview(label7!)
        h3StackView.addArrangedSubview(label8!)
        h3StackView.setCustomSpacing(UIScreen.main.bounds.width * 0.15, after: label8!)
        h3StackView.addArrangedSubview(infoButton)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            verticalStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            mySlider.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7),
        ])
        
        addButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        mySlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func showAlert(_ sender: UIButton) {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        
        var title: String
        if difference == 0 {
            title = "Perfect!"
        } else if (difference > 0 && difference < 50) {
            title = "You almost had it!"
        } else {
            title = "Not even close..."
        }
        
        let message = "You scored \(points) points" +
        "\nYour choice: \(currentValue)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
        startNewRound()
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        currentValue = lroundf(sender.value)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        mySlider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        label2?.text = "\(targetValue)"
        label6?.text = "\(score)"
        label8?.text = "\(round)"
    }
}

