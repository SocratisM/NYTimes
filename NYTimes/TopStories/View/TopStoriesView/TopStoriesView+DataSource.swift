
//
//  TopStoriesViewControllerDataSource.swift
//  NYTimes
//
//  Created by Socratis on 05/10/2017.
//

import Foundation
import UIKit

extension TopStoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as! StoryTableViewCell
        let story = eventHandler?.fetchedResultsController.object(at: indexPath) as? Story
        guard let item = story else { return cell }
        let displayData = StoryDisplayData(story: item)
        cell.setUpWith(displayData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = eventHandler?.fetchedResultsController.sections?.first?.numberOfObjects {
            tableView.backgroundView = nil
            if(numberOfRows == 0) {
                if(!isLoading()) {
                    self.emptyResults()
                }
            }
            return numberOfRows
        }
        return 0
    }
}
