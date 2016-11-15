//
//  AudioRecordViewController.swift
//  VoiceNotes
//
//  Created by Frain on 15/11/2016.
//  Copyright © 2016 Frain. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class AudioRecordViewController: UIViewController, AudioPlayable {
	
	@IBOutlet weak var playBtn: UIButton!
	
	var player: AVAudioPlayer?
	var isPlaying: Bool = false
	var startTime: Date?
	
	var recorder: AVAudioRecorder?
	var recorderSeetings: [String: Any] = [
		AVFormatIDKey: kAudioFormatMPEG4AAC,
		AVNumberOfChannelsKey: 2,
		AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
		AVEncoderBitRateKey: 320000,
		AVSampleRateKey: 44100.0
	]
	
	override func viewDidLoad() {
		try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
		try? AVAudioSession.sharedInstance().setActive(true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		stopPlaying()
	}
	
	@IBAction func downAction(_ sender: UIButton) {
		startTime = Date()
		recorder = try? AVAudioRecorder(url: path, settings: recorderSeetings)
		recorder?.prepareToRecord()
		recorder?.record()
	}
	
	@IBAction func upAction(_ sender: UIButton) {
		recorder?.stop()
		playBtn.isHidden = false
		let entity = NSEntityDescription.entity(forEntityName: "Voice", in: CoreDataStack.context)
		let voice = entity.map { Voice(entity: $0, insertInto: CoreDataStack.context) }
		voice?.time = startTime as NSDate?
		CoreDataStack.saveContext()
	}
	
	@IBAction func playAction(_ sender: UIButton) {
		playAction()
	}
	
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		stopPlaying()
	}
}
