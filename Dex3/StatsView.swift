//
//  StatsView.swift
//  Dex3
//
//  Created by Ruben Movsisyan on 3/31/24.
//

import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject var pokemon: Pokemon
    
    var body: some View {
        Chart(pokemon.stats) { stat in
            BarMark(x: .value("Value", stat.value),
                    y: .value("Stat", stat.label)
            )
            .annotation(position: .trailing) {
                Text("\(stat.value)")
                    .padding(.top, -5)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
        .frame(height: 200)
        .padding([.leading, .bottom, .trailing])
        .foregroundStyle(Color(pokemon.types![0].capitalized))
        .chartXScale(domain: 0...pokemon.highestStat.value + 10)
    }
}

#Preview {
    StatsView()
        .environmentObject(SamplePokemon.samplePokemon)
}
