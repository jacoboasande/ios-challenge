//
//  AdDetailView.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 16/5/25.
//

import SwiftUI

struct AdDetailView: View {
    @ObservedObject var viewModel: AdDetailViewModel

    @State private var selectedImageIndex = 0
    @State private var expandedDescription = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                photoGallery
                titleSection
                priceSection
                featuresSection
                favoriteSection
                descriptionSection
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleFavorite()
                }) {
                    SwiftUI.Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .accessibilityLabel(viewModel.isFavorite ? "Quitar de favoritos" : "Agregar a favoritos")
                }
            }
        }
    }

    // MARK: - Subviews

    @ViewBuilder
    private var photoGallery: some View {
        if !viewModel.listItem.multimedia.images.isEmpty,
           let url = URL(string: viewModel.listItem.multimedia.images[selectedImageIndex].url) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 240)
                case .success(let image):
                    ZStack(alignment: .bottomLeading) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, minHeight: 220, maxHeight: 240)
                            .clipped()
                            .cornerRadius(12)
                        let overlayText = viewModel.listItem.multimedia.images[selectedImageIndex].tag.localized
                        if !overlayText.isEmpty {
                            Text("\(overlayText)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(8)
                                .padding()
                        }
                    }
                    .frame(height: 200)
                    .clipped()
                case .failure:
                    SwiftUI.Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 240)
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
        }


        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(viewModel.listItem.multimedia.images.enumerated()), id: \.offset) { (idx, img) in
                    let imgURL = img.url
                    AsyncImage(url: URL(string: imgURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 72, height: 72)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 72, height: 72)
                                .clipped()
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedImageIndex == idx ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    selectedImageIndex = idx
                                }
                        case .failure:
                            SwiftUI.Image(systemName: "photo")
                                .resizable()
                                .frame(width: 72, height: 72)
                                .foregroundColor(.secondary)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
            .padding(.vertical, 2)
        }
    }

    @ViewBuilder
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(viewModel.titleLine1)")
                .font(.title2).bold()
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            Text("\(viewModel.titleLine2)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 2)
    }

    @ViewBuilder
    private var priceSection: some View {
        Text("\(viewModel.listItem.price, specifier: "%.0f") \(viewModel.detail.priceInfo.currencySuffix)")
            .font(.title)
            .bold()
            .foregroundColor(.green)
    }

    @ViewBuilder
    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Habitaciones: \(viewModel.listItem.rooms)")
                Spacer()
                Text("Baños: \(viewModel.listItem.bathrooms)")
            }
            HStack {
                Text("Superficie: \(String(format: "%.1f", viewModel.listItem.size)) m²")
                Spacer()
                Text("Aire Acondicionado: \(viewModel.listItem.features.hasAirConditioning ? "Sí" : "No")")
            }
            HStack {
                Text("Parking: \(viewModel.listItem.parkingSpace?.hasParkingSpace ?? false ? "Sí" : "No")")
            }
        }
        .font(.subheadline)
    }

    @ViewBuilder
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(viewModel.listItem.description)
                .font(.body)
                .lineLimit(expandedDescription ? nil : 4)
                .foregroundColor(.primary)
            Button(action: {
                withAnimation { expandedDescription.toggle() }
            }) {
                Text(expandedDescription ? "Leer menos" : "Leer más")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
    }

    @ViewBuilder
    private var favoriteSection: some View {
        if viewModel.isFavorite, let dateString = viewModel.favoritedDateString {
            HStack(spacing: 6) {
                SwiftUI.Image(systemName: "calendar")
                    .foregroundColor(.orange)
                Text("Añadido a favoritos el \(dateString)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 2)
        }
    }
}


