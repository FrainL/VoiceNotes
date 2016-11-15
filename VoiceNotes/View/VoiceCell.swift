//
//  VoiceCell.swift
//  VoiceNotes
//
//  Created by Frain on 15/11/2016.
//  Copyright © 2016 Frain. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceCell: UITableViewCell {
	
	@IBOutlet weak var playBtn: UIButton!
	@IBOutlet weak var name: UILabel!
	
	var startTime: Date?
	weak var delegate: AudioPlayable?
	
	@IBAction func playAction(_ sender: UIButton) {
		if playBtn.title(for: .normal) == "Play" { delegate?.stopPlaying() }
		delegate?.startTime = startTime
		delegate?.playBtn = playBtn
		delegate?.playAction()
	}
}
