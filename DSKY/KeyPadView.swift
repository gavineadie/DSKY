//
//  KeyPadView.swift
//  DSKY
//
//  Created by Gavin Eadie on 7/7/24.
//

import SwiftUI
import AVFoundation

/*
            ┌────────────────────────────────────────────────────┐
            │         ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮         │
            │         ┆+   ┆ ┆7   ┆ ┆8   ┆ ┆9   ┆ ┆CLR ┆         │
            │  ╭╌╌╌╌╮ ┆    ┆ ┆    ┆ ┆    ┆ ┆    ┆ ┆    ┆ ╭╌╌╌╌╮  │
            │  ┆VERB┆ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ┆ENTR┆  │
            │  ┆    ┆ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ┆    ┆  │
            │  ╰╌╌╌╌╯ ┆-   ┆ ┆4   ┆ ┆5   ┆ ┆6   ┆ ┆PRO ┆ ╰╌╌╌╌╯  │
            │  ╭╌╌╌╌╮ ┆    ┆ ┆    ┆ ┆    ┆ ┆    ┆ ┆    ┆ ╭╌╌╌╌╮  │
            │  ┆NOUN┆ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ┆RSET┆  │
            │  ┆    ┆ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ╭╌╌╌╌╮ ┆    ┆  │
            │  ╰╌╌╌╌╯ ┆0   ┆ ┆1   ┆ ┆2   ┆ ┆3   ┆ ┆KEY ┆ ╰╌╌╌╌╯  │
            │         ┆    ┆ ┆    ┆ ┆    ┆ ┆    ┆ ┆REL ┆         │
            │         ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯ ╰╌╌╌╌╯         │
            └────────────────────────────────────────────────────┘
*/

struct KeyPadView: View {

    var body: some View {
        HStack {
            VStack {
                KeyView(keyCode: 17) // "VERB"
                KeyView(keyCode: 31) // "NOUN"
            }

            VStack {
                HStack {
                    KeyView(keyCode: 26) //  "+"
                    KeyView(keyCode: 07) //  "7"
                    KeyView(keyCode: 08) //  "8"
                    KeyView(keyCode: 09) //  "9"
                    KeyView(keyCode: 30) //  "CLR"
                }

                HStack {
                    KeyView(keyCode: 27) //  "-"
                    KeyView(keyCode: 04) //  "4"
                    KeyView(keyCode: 05) //  "5"
                    KeyView(keyCode: 06) //  "6"
                    KeyView(keyCode: 99) //  "PRO" << cheat
                }

                HStack {
                    KeyView(keyCode: 16) //  "0"
                    KeyView(keyCode: 01) //  "1"
                    KeyView(keyCode: 02) //  "2"
                    KeyView(keyCode: 03) //  "3"
                    KeyView(keyCode: 25) //  "KEY REL"
                }
            }

            VStack {
                KeyView(keyCode: 28) // "ENTR"
                KeyView(keyCode: 18) // "RSET"
            }
        }
    }
}

#Preview {
    KeyPadView()
}

struct KeyView: View {
    var keyCode: UInt16

    var body: some View {
/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ .. single characters are 28 points and words are 12 points                                       ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/
        let fontSize: CGFloat = (1...16).contains(keyCode) ||
                               (26...27).contains(keyCode) ? 28 : 12

        Text(keyText(keyCode))
            .font(.custom("Gorton-Normal-120",
                          fixedSize: fontSize))
            .baselineOffset(-4.0)
            .tracking(2.0)
            .foregroundColor(keyTextColor)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .lineSpacing(4.0)
            .frame(width: keyPadSize,
                   height: keyPadSize)
            .background(keyPadColor)
            .padding(.all, keyPadding)
            .cornerRadius(keyCorner)
/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ the "PRO" key is a long press                                                                    ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/
            .onTapGesture {
                if keyCode < 99 {
                    logger.log("«««    \(keyText(keyCode)) (\(keyCode))")

                    if let clickURL = Bundle.main.url(forResource: "dsky", withExtension: "aiff") {
                        var clickSound: SystemSoundID = 0
                        AudioServicesCreateSystemSoundID(clickURL as CFURL, &clickSound)
                        AudioServicesPlaySystemSound(clickSound)
                    }
                    Task {
                        do {
                            try await model.network.connection.rawSend(data: formIoPacket(0o015, keyCode))
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .simultaneousGesture(LongPressGesture(minimumDuration: 1.0)
                .onEnded { _ in
                    logger.log("«««    \(keyText(keyCode)) (\(keyCode))")
                    Task {
                        do {
                            try await model.network.connection.rawSend(data: formIoPacket(0o015, keyCode))
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                })
    }
}

#Preview {
    KeyView(keyCode: 6)
}

#Preview {
    KeyView(keyCode: 255)
}

func keyText(_ code: UInt16) -> String { keyDict[code] ?? "ERROR" }

let keyDict: [UInt16:String] = [
    17: "VERB",
    31: "NOUN",
    16: "0",
    01: "1",
    02: "2",
    03: "3",
    04: "4",
    05: "5",
    06: "6",
    07: "7",
    08: "8",
    09: "9",
    27: "-",
    26: "+",
    30: "CLR",
    99: "PRO",
    25: "KEY REL",
    28: "ENTR",
    18: "RSET"
]
