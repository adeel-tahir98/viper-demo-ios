//
//  NetworkManagerUtility.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 12/17/22.
//

import Foundation
import Reachability

class NetworkManagerUtility: NSObject {
    
    var reachability: Reachability!

    // Create a singleton instance
    static let sharedInstance: NetworkManagerUtility = { return NetworkManagerUtility() }()


    override init() {
        super.init()

        // Initialise reachability
        reachability = try? Reachability()

        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )

        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }

    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManagerUtility.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    static func isConnectedToNetwork() -> Bool {
        if NetworkManagerUtility.sharedInstance.reachability.connection != .unavailable {
            return true
        }
        return false
    }

    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }

    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }

    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }

    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManagerUtility) -> Void) {
        if (NetworkManagerUtility.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManagerUtility.sharedInstance)
        }
    }
}
