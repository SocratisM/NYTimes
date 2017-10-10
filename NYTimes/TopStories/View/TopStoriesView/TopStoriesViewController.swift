//
//  TopStoriesViewController.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import UIKit

class TopStoriesViewController: UIViewController {
    
    private let storyCellFileName = "StoryTableViewCell"
    let cellReuseIdentifier = "StoryTableViewCell"
    
    var activityIndicatorView: UIActivityIndicatorView!
    var eventHandler: TopStoriesEventHandlerProtocol?
    @IBOutlet weak var tableView: UITableView!
    var selectedStory: Story!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(eventHandler?.fetchedResultsController.sections?.first?.numberOfObjects == 0) {
            tableView.separatorStyle = .none
            activityIndicatorView.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Stories"
     
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        //tableview setup
        tableView.backgroundView = activityIndicatorView
        tableView.separatorStyle = .none
        
        tableView.register(StoryTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //Clears local stories in order to fetch new stories.
        //Todo: instead of refreshing with every launch, use other ways to handle refreshing(push notification etc)
        CoreDataStack.sharedInstance.clearData()

        //handle launch
       eventHandler?.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isLoading() -> Bool {
        return activityIndicatorView.isAnimating
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "storyDetailsSegue") {
            let storyDetailsController = segue.destination as! StoryDetailsViewController
            storyDetailsController.currentStory = selectedStory
        }
    }
    
    func emptyResults() {
        let emptyResults: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        emptyResults.text          = "No results available"
        emptyResults.textColor     = .white
        emptyResults.textAlignment = .center
        tableView.backgroundView  = emptyResults
    }
}

extension TopStoriesViewController: UITableViewDelegate  {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let story = eventHandler?.fetchedResultsController.object(at: indexPath)  as? Story else { return }
        selectedStory = story
        performSegue(withIdentifier: "storyDetailsSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Todo: calculate dynamically by measuring title text height
        return 200
    }
}

extension TopStoriesViewController: TopStoriesViewProtocol {
    func startUpdate() {
        tableView.beginUpdates()
    }
    
    func endUpdate() {
        self.tableView.separatorStyle = .singleLine
        activityIndicatorView.stopAnimating()
        tableView.endUpdates()
    }
    
    func addStory(indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func removeStory(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func showAlertController(controller alert: UIAlertController, completion: (() -> Void)?) {
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: completion)
        activityIndicatorView.stopAnimating()
        self.tableView.reloadData()
    }
}
