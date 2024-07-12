//
//  StatusView.swift
//  DSKY
//
//  Created by Gavin Eadie on 7/7/24.
//

import SwiftUI

struct StatusView: View {
    var body: some View {
        ZStack {
            PanelsView()

            Grid {
                GridRow {
                    StatusLightView(words: "UPLINK\nACTY")
                    StatusLightView(words: "TEMP")
                }

                GridRow {
                    StatusLightView(words: "NO  ATT")
                    StatusLightView(words: "GIMBAL\nLOCK")
                }

                GridRow {
                    StatusLightView(words: "STBY")
                    StatusLightView(words: "PROG")
                }

                GridRow {
                    StatusLightView(words: "KEY  REL")
                    StatusLightView(words: "RESTART")
                }

                GridRow {
                    StatusLightView(words: "OPR  ERR")
                    StatusLightView(words: "TRACKER")
                }

                GridRow {
                    StatusLightView(words: "")
                    StatusLightView(words: "ALT")
                }

                GridRow {
                    StatusLightView(words: "")
                    StatusLightView(words: "VEL")
                }
            }
        }
    }
}

#Preview {
    StatusView()
}

struct StatusLightView: View {
    var words: String
    var light: Bool = false

    var body: some View {
        let color: Color = light ? .yellow : .white

        ZStack {
            RoundedRectangle(cornerRadius: statusCorner)
                .fill(color)
                .border(Color(statusBorder), width: 1)
                .frame(width: statusWidth,
                       height: statusHeight)

            Text(words)
                .font(.custom("Gorton-Normal-180",
                              fixedSize: 12))
                .baselineOffset(-2.0)
                .foregroundColor(Color(.black))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .lineSpacing(4.0)
        }
    }
}

#Preview {
    StatusLightView(words: "WORDS")
}

#Preview {
    StatusLightView(words: "WORDS", light: true)
}
