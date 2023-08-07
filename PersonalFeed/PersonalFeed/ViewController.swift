import UIKit

class ViewController: UIViewController {

    var selectedTopicsCount: Int = 0 {
        didSet {
            selectedTopicsButton.setTitle("\(selectedTopicsCount) topics selected", for: .normal)
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "personalize your feed"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select 10 or more topic"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let sectionTitles = ["Most Popular", "Life Style", "Health"]
    let popularTopics = ["U.S Politics", "Tech Companies", "TV & Movies", "Recipes", "Travel", "Celebs", "Restaurant"]
    let trendingTopics = ["Travel Tips", "Luxury Homes", "Architecture", "Interior Design", "Fashion", "Mens Style", "Cars", "Wine&Drinks", "Home Product", "Kitchen Product"]
    let newTopics = ["Health", "Exercise"]

    let selectedTopicsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("0 topics selected", for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(selectedTopicsButton)
        
        var lastAnchor: NSLayoutYAxisAnchor = subtitleLabel.bottomAnchor
        
        for topics in [popularTopics, trendingTopics, newTopics] {
            let sectionIndex = [popularTopics, trendingTopics, newTopics].firstIndex(of: topics)!
            let popularLabel: UILabel = {
                let label = UILabel()
                label.text = sectionTitles[sectionIndex]
                label.font = UIFont.boldSystemFont(ofSize: 18)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            view.addSubview(popularLabel)
            NSLayoutConstraint.activate([
                popularLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                popularLabel.topAnchor.constraint(equalTo: lastAnchor, constant: 20)
            ])

            let topicButtons = createTopicButtons(for: topics)
            let stackView = UIStackView(arrangedSubviews: topicButtons)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 10),
                stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
            ])
            
            lastAnchor = stackView.bottomAnchor
        }

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            selectedTopicsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            selectedTopicsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func createTopicButtons(for topics: [String]) -> [UIButton] {
        var topicButtons: [UIButton] = []
        for topic in topics {
            let button = UIButton(type: .system)
            button.setTitle(topic, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)  // Increased padding here
            button.layer.cornerRadius = 20
            button.backgroundColor = .lightGray
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(topicButtonTapped), for: .touchUpInside)
            topicButtons.append(button)
        }
        return topicButtons
    }

    @objc func topicButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            selectedTopicsCount += 1
            sender.backgroundColor = .blue
        } else {
            selectedTopicsCount -= 1
            sender.backgroundColor = .lightGray
        }
    }
}
