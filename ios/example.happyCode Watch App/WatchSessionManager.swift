//
//  WatchSessionManager.swift
//  example.happyCode Watch App
//
//  Created by 梶村拓斗 on 2025/08/31.
//

import WatchConnectivity
import SwiftUI
import Combine

class WatchSessionManager: NSObject, ObservableObject, WCSessionDelegate {
    @Published var lastMessageText: String = ""

    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    // watchOSでは必須のデリゲート実装（セッションの有効化結果）
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // セッションのアクティベーション結果をログ
        print("WCSession activationDidCompleteWith: state=\(activationState.rawValue), error=\(String(describing: error))")
    }

    // メッセージ受信時に呼ばれる（返信不要）
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let text = Self.stringify(message)
        print("iOSからメッセージを受信: \(text)")
        DispatchQueue.main.async { [weak self] in
            self?.lastMessageText = text
        }
    }

    // メッセージ受信時に呼ばれる（返信ハンドラあり）
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let text = Self.stringify(message)
        print("iOSからメッセージを受信(Reply可): \(text)")
        DispatchQueue.main.async { [weak self] in
            self?.lastMessageText = text
        }
        // 必要に応じてACKを返す
        replyHandler(["status": "ok"]) // iOS側が返信待ちの場合のみ呼ばれる
    }

    private static func stringify(_ message: [String: Any]) -> String {
        if JSONSerialization.isValidJSONObject(message),
           let data = try? JSONSerialization.data(withJSONObject: message, options: [.sortedKeys]),
           let text = String(data: data, encoding: .utf8) {
            return text
        } else {
            return String(describing: message)
        }
    }

    #if os(iOS)
    // iOS側でWCSessionDelegateに準拠するために必須
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WCSession sessionDidBecomeInactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("WCSession sessionDidDeactivate")
        // 新しいApple Watchのペアリング後に再アクティベートが必要な場合があります
        WCSession.default.activate()
    }
    #endif

    // 他の必要なdelegateメソッドも実装可能
}
