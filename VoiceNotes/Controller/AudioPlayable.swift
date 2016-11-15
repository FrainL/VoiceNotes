//
//  AudioPlayable.swift
//  VoiceNotes
//
//  Created by Frain on 15/11/2016.
//  Copyright © 2016 Frain. All rights reserved.
//
import Foundation
import AVFoundation
import UIKit

protocol AudioPlayable: AVAudioPlayerDelegate {
	
	var playBtn: UIButton! { get set }
	var player: AVAudioPlayer? { get set }
	var isPlaying: Bool { get set }
	var startTime: Date? { get set }
}

extension AudioPlayable {
	
	var path: URL! {
		return startTime.flatMap {
			URL(string: NSHomeDirectory() + "/Documents/\($0.timeIntervalSince1970).acc")
		}
	}
	
	func playAction() {
		isPlaying ? stopPlaying() : startPlaying()
	}
	
	func stopPlaying() {
		if isPlaying {
			isPlaying = false
			playBtn?.setTitle("Play", for: .normal)
			player?.stop()
		}
	}
	
	func startPlaying() {
		isPlaying = true
		playBtn?.setTitle("Stop", for: .normal)
		player = try? AVAudioPlayer(contentsOf: path)
		player?.play()
		player?.delegate = self
	}
}
