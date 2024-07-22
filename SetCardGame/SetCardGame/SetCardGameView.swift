//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by zhira on 7/17/24.
//

import SwiftUI

struct SetCardGameView: View {
    typealias Card = SetGameModel.Card
    @ObservedObject var viewModel: SetCardGameInterpreter
    
    // this set stores the card ids that will be rendered in the table
    @State private var dealt = Set<Card.ID>()
    // this set stores the card ids that will be rendered in the discard pile
    @State private var matched = Set<Card.ID>()
    
    @State var animateMatching: Bool = false
    
    @Namespace private var dealingNamespace
    @Namespace private var matchingNamespace
    @Namespace private var discardingNamespace
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private func isMatched(_ card: Card) -> Bool {
        matched.contains(card.id)
    }
    
    // card in the deck card view
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) && !$0.isMatched }
    }
    
    private var selectedCards: [Card] {
        viewModel.cards.filter { $0.isSelected }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                header
                cards
                    .foregroundColor(.blue)
                    .animation(.default, value: viewModel.cards)
                footer
            }
            .onChange(of: viewModel.score) {
                withAnimation(.linear(duration: 1)) {
                    animateMatching = true
                } completion: {
                    discard()
                }
            }
            if animateMatching {
                matchingContainer
            }
        }
        .padding()
    }
    
    private func discard() {
        withAnimation(.easeInOut(duration: 1)) {
            selectedCards.forEach { card in
                matched.insert(card.id)
            }
            animateMatching = false
            
        } completion: {
            selectedCards.forEach { card in
                dealt.remove(card.id)
            }
            viewModel.deselectCards()
            if (dealt.count < 12) {
                deal(Constants.Deck.nextNumberOfCards)
            }
        }
    }
    
    private var matchingContainer: some View {
        GeometryReader { geometry in
            let width = (geometry.size.width / CGFloat(selectedCards.count + 1)).rounded(.down)
            HStack {
                ForEach(selectedCards.reversed()) { card in
                    CardView(card)
                        .frame(width: width, height: width / Constants.cardAspectRatio)
                        .matchedGeometryEffect(id: card.id, in: matchingNamespace)
                        .matchedGeometryEffect(id: card.id, in: discardingNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                        .zIndex(Constants.matchingCardZIndex)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                let sText = Text("S").coloredText(.red)
                let eText = Text("E").coloredText(.green)
                let tText = Text("T").coloredText(.blue)
                Text("\(sText)\(eText)\(tText)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Button(
                    action: {
                        viewModel.startNewGame()
                        dealt.removeAll()
                        matched.removeAll()
                        deal(Constants.Deck.initialNumberOfCards, animate: true)
                    }
                ) {
                    Label("New Game", systemImage: "plus")
                }
                .buttonStyle(.bordered)
                .tint(.indigo)
            }
            Spacer()
            score
        }
        .frame(height: Constants.headerHeight)
        .padding(Constants.spacing)
    }
    
    private var score: some View {
        VStack {
            Text("Sets Found")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.indigo)
            Text("\(viewModel.score)")
                .font(.system(size: Constants.scoreFontSize))
                .fontWeight(.semibold)
                .foregroundColor(.indigo)
                .animation(nil)
        }
    }

    private var cards: some View {
        let dealtCards = viewModel.cards.filter { isDealt($0) }
        return AspectLazyVGrid(dealtCards.reversed(), aspectRatio: Constants.cardAspectRatio) { card in
            if !card.isMatched {
                CardView(card)
                    .padding(Constants.spacing)
                    .onTapGesture {
                        choose(card)
                    }
                    .transition(.asymmetric(insertion: .identity, removal: .slide))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .matchedGeometryEffect(id: card.id, in: matchingNamespace)
            } else {
                Color.clear
            }
        }
    }
    
    private var footer: some View {
        HStack(alignment: .top) {
            VStack {
                if !undealtCards.isEmpty {
                    deck
                    Text("\(undealtCards.count)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                        .animation(nil)
                } else {
                    Color.clear
                }
            }
            Spacer()
            Button(
                action: viewModel.shuffle
            ) {
                Label("Shuffle", systemImage: "arrow.clockwise")
            }
            .buttonStyle(GrowingButton(color: .indigo))
            Spacer()
            discardPile
        }
    }
    
    private var discardPile: some View {
        let cards = viewModel.cards.filter { isMatched($0) }
        return ZStack {
            ForEach(cards.indices, id: \.self) { index in
                CardView(cards[index])
                    .stacked(at: index, in: cards.count)
                    .matchedGeometryEffect(id: cards[index].id, in: discardingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .zIndex(Constants.matchingCardZIndex)
            }
        }
        .frame(width: Constants.Deck.width, height: Constants.Deck.height)
    }
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards.indices, id: \.self) { index in
                let card = undealtCards[index]
                CardView(card, isFaceUp: false)
                    .stacked(at: index, in: undealtCards.count)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: Constants.Deck.width, height: Constants.Deck.height)
        .onTapGesture {
            deal(Constants.Deck.nextNumberOfCards)
        }
        .disabled(dealt.count > Constants.Deck.minNumberOfCards)
        .onAppear {
            // deal 12 initial cards without any animation
            deal(Constants.Deck.initialNumberOfCards, animate: false)
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation(.linear(duration: 2)) {
            viewModel.choose(card)
        }
    }

    
    private func deal(_ numberOfCards: Int, animate: Bool = true) {
        var delay: TimeInterval = 0
        for card in undealtCards.suffix(numberOfCards).reversed() {
            if animate {
                withAnimation(Constants.dealAnimation
                    .delay(delay)) {
                    _ = dealt.insert(card.id)
                }
            } else {
                dealt.insert(card.id)
            }
            viewModel.dealCard(card)
            delay += Constants.dealInterval
        }
    }
    
    private struct Constants {
        static let spacing: CGFloat = 4
        static let cardAspectRatio: CGFloat = 2 / 3
        static let scoreFontSize: CGFloat = 64
        static let headerHeight: CGFloat = 96
        
        static let matchingCardZIndex: Double = 100
        struct Deck {
            static let width: CGFloat = 50
            static let height: CGFloat = width / cardAspectRatio
            static let initialNumberOfCards: Int = 12
            static let nextNumberOfCards: Int = 3
            static let minNumberOfCards: Int = 15
        }
        static let dealInterval: TimeInterval = 0.15
        static let dealAnimation: Animation = .easeInOut(duration: 2)
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 0.1)
    }
}

#Preview {
    SetCardGameView(viewModel: SetCardGameInterpreter())
}
