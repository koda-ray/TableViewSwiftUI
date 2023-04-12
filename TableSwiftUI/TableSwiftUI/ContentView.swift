//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Brown, Rachel on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Sundance Records and Tapes", neighborhood: "San Marcos", desc: "Sundance records has served the Austin/ San Marcos areas since 1977. They have thousands of posters, records, and rare collectibles for browsing in an authentic 70s rock and roll style shop.", lat: 29.883970, long: -97.940320, imageName: "p1"),
    Item(name: "Alchemy Records", neighborhood: "San Marcos", desc: "Alchemy Records is a self-proclaimed weird record shop for weird people! Records, clothing, crystals, and more - you never know what you'll find. ", lat: 29.88143214306098, long: -97.93955806931568, imageName: "p2"),
    Item(name: "Studio 1916", neighborhood: "Kyle", desc: "Studio 1916 is a recording studio out of Kyle, TX. This studio hosts most local artists and offers a complete collection of recording tech. Anything you'd like to record, from audiobooks to albums, Studio 1916 has you covered.", lat: 29.999040487416327, long: -97.86104207149017, imageName: "p3"),
    Item(name: "Plum Creek Records & Tapes", neighborhood: "Lockhart", desc: "A superstore of classic posters and vinyls, even offering online order pick-ups. This groovy little record shop has earned itself a loyal community and frequently hosts live music events with food trucks and drinks.", lat: 29.881940, long: -97.671560, imageName: "p4"),
    Item(name: "Stingray Records", neighborhood: "New Braunfels", desc: "Stingray records is a happy little record store out of New Braunfels, TX. They have a seemigly endless collection of record and vinyl for purchase and browsing. Stingray records also has state of the art recording studios avaliable to artists.", lat: 29.711030, long: -98.120890 , imageName: "p5")
]
struct Item: Identifiable {
        let id = UUID()
        let name: String
        let neighborhood: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.91987109586619, longitude: -97.84709836027282), span: MKCoordinateSpan(latitudeDelta: 0.30, longitudeDelta: 0.30))

    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.neighborhood)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .overlay(
                                            Text(item.name)
                                                .font(.subheadline)
                                                .foregroundColor(.black)
                                                .fixedSize(horizontal: true, vertical: false)
                                                .offset(y: 25)
                                        )
                                }
                            }
                            .frame(height: 300)
                            .padding(.bottom, -30)
                
            }
            .listStyle(PlainListStyle())
                    .navigationTitle("Central Texas Records")
        }
        
    }
}
struct DetailView: View {
    @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
       let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: 200)
               Text("Neighborhood: \(item.neighborhood)")
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
                   }
                    .navigationTitle(item.name)
                    Spacer()
           
           Map(coordinateRegion: $region, annotationItems: [item]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                        .overlay(
                            Text(item.name)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .offset(y: 25)
                        )
                }
            }
                .frame(height: 300)
                .padding(.bottom, -30)
        }
     }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
