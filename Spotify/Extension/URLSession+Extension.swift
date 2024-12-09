//
//  URLSession+Extension.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import Foundation

extension URLSession {
    func cancelAllOngoingRequest(_ completionHandler: (() -> Void)?) {
        self.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
            completionHandler?()
        }
    }
}
