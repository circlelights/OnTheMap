//
//  GCDBlackBox.swift
//  OnTheMap
//
//  Created by Jason Isler on 5/26/17.
//  Copyright © 2017 Developer2017. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
}
}
