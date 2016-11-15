//
//  VoiceListViewController.swift
//  VoiceNotes
//
//  Created by Frain on 15/11/2016.
//  Copyright © 2016 Frain. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class AudioListViewController: UITableViewController, NSFetchedResultsControllerDelegate, AudioPlayable {
	
	var fetchedResultsController: NSFetchedResultsController<Voice>?
	
	weak var playBtn: UIButton!
	var player: AVAudioPlayer?
	var isPlaying: Bool = false
	var startTime: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

		let fetchRequest = NSFetchRequest<Voice>(entityName: "Voice")
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: false)]
		
		fetchedResultsController = NSFetchedResultsController(
			fetchRequest: fetchRequest,
			managedObjectContext: CoreDataStack.context,
			sectionNameKeyPath: nil,
			cacheName: nil
		)
		fetchedResultsController?.delegate = self
		try? fetchedResultsController?.performFetch()
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		stopPlaying()
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voiceCell", for: indexPath)
		if let cell = cell as? VoiceCell, let voice = fetchedResultsController?.object(at: indexPath) {
			let time = voice.time as Date?
			let formatter = DateFormatter()
			formatter.dateFormat = "MMMM dd, HH:mm:ss "
			if !(isPlaying && time == startTime) { cell.playBtn.setTitle("Play", for: .normal) }
			cell.delegate = self
			cell.startTime = time
			cell.name.text = time.map { formatter.string(from: $0) }
			return cell
		}
        return cell
	}
	
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		stopPlaying()
	}
}
