//
//  Network.swift
//  DSKY
//
//  Created by Gavin Eadie on 7/15/24.
//

import Foundation
import Network

struct Network {

    let connection: NWConnection
    let didStopCallback: ((Error?) -> Void)?

    init(_ host: String = "127.0.0.1", _ port: UInt16 = 12345) {

        self.didStopCallback = { error in
            exit( error == nil ? EXIT_SUCCESS : EXIT_FAILURE )
        }

        let tcpOptions = NWProtocolTCP.Options()
        tcpOptions.connectionTimeout = 10

        self.connection = NWConnection(host: NWEndpoint.Host(host),
                                       port: NWEndpoint.Port(rawValue: port)!,
                                       using: NWParameters(tls: nil,
                                                           tcp: tcpOptions))
        self.connection.stateUpdateHandler = self.stateDidChange(to:)

        self.connection.start(queue: .main)
    }

    private func stateDidChange(to state: NWConnection.State) {
        switch state {
            case .setup:
                print("connection .setup")
                break
            case .waiting(let error):
                print("connection .waiting: \(error)")
            case .preparing:
                print("connection .preparing")
                break
            case .ready:
                print("connection .ready")
            case .failed(let error):
                print("connection .failed")
                self.connectionDidFail(error: error)
            case .cancelled:
                print("connection .cancelled")
                break
            default:
                print("connection .default")
                break
        }
    }

    private func connectionDidFail(error: Error) {
        print("connection did fail, error: \(error)")
        self.stop(error: error)
    }

    private func stop(error: Error?) {
        print("... \(#function)")
        self.connection.stateUpdateHandler = nil
        self.connection.cancel()
        if let didStopCallback = self.didStopCallback {
            didStopCallback(error)
        }
    }

    public func send(data: Data) {
        print("... \(#function)")
        self.connection.send(content: data,
                             completion: .contentProcessed( { error in
            if let error = error {
                self.connectionDidFail(error: error)
                return
            }
        }))
    }

    func sendPacket(_ packet: Data) {
        logger.log("<<< \(prettyString(packet))")
        send(data: packet)
    }

    func recv() {
        connection.receive(minimumIncompleteLength: 1,
                           maximumLength: 4) { (content, _, connectionEnded, error) in

            if let data = content, !data.isEmpty { _ = parseIoPacket(data) }

            if connectionEnded {
                print("connection did end")
                self.stop(error: nil)
            } else if let error = error {
                connectionDidFail(error: error)
            } else {
                recv()
            }
        }
    }
}

