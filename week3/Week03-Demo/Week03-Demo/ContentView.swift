//
//  ContentView.swift
//  Week03-Demo
//
//  Created by 何若琪 on 9/23/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star")
                .resizable(resizingMode: .tile)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(Color.pink)
                .padding(7.0)
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("My")
                .font(.largeTitle)
                .fontWeight(.thin)
                .foregroundColor(Color.pink)
                .lineSpacing(20)
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.thin)
                .foregroundColor(Color.pink)
                
        }
        .padding()
    }
}





#Preview {
    ContentView()
}



struct Page1: View {
  var body: some View {
    VStack() {
      HStack {
        Image(systemName: "chair.lounge.fill")
          .resizable()
          .foregroundColor(Color.pink)
          .frame(width:100, height: 100)
        Image(systemName: "washer")
          .resizable()
          .foregroundColor(Color.pink)
          .frame(width:100, height: 100)
        Image(systemName: "cooktop")
          .resizable()
          .foregroundColor(Color.pink)
          .frame(width:100, height: 100)
      }
      HStack {
        Image(systemName: "fireplace")
          .resizable()
          .foregroundColor(Color.pink)
          .frame(width:100, height: 100)
        Image(systemName: "dryer")
          .resizable()
          .foregroundColor(Color.pink)
          .frame(width:100, height: 100)
        Image(systemName: "frying.pan.fill")
          .resizable()
          .foregroundColor(Color.pink)
          .frame(width:100, height: 100)
      }
      // Spacer()
    }
  }
}

struct Page1_Previews: PreviewProvider {
  static var previews: some View {
    Page1()
  }
}

import SwiftUI

// Array of image names
let imageArray = [
  "chair.lounge.fill",
  "washer",
  "cooktop",
  "fireplace",
  "dryer",
  "frying.pan.fill",
]

struct Page2: View {
  var body: some View {
    VStack {
      ForEach(0 ..< imageArray.count) { index in
        Image(systemName: imageArray[index])
          .resizable()
          .frame(width:100, height: 100)
          .foregroundColor(Color.pink)
      }
    }
  }
}

struct Page2_Previews: PreviewProvider {
  static var previews: some View {
    Page2()
  }
}




import SwiftUI

struct Page3: View {
  var body: some View {
    NavigationView {
      List {
        ForEach(0 ..< imageArray.count) { index in
          let item = imageArray[index]
          NavigationLink {
            VStack {
              Image(systemName: item)
                .resizable()
                .frame(width:100, height: 100)
                .foregroundColor(Color.pink)
              Text(item)
              Spacer()
            }
          } label: {
            HStack {
              Image(systemName: item)
                .resizable()
                .frame(width:100, height: 100)
                .foregroundColor(Color.pink)
              Text(item)
              Spacer()
            }
          }
        }
      }
    }
  }
}

struct Page3_Previews: PreviewProvider {
  static var previews: some View {
    Page3()
  }
}




import SwiftUI

struct Page4: View {
  var body: some View {
    NavigationView {
      List {
        ForEach(0 ..< imageArray.count) { index in
          let item = imageArray[index]
          NavigationLink(
            destination: ItemDetail(item: item)
          )  {
            ItemRow(item: item)
          }
        }
      }
      .navigationTitle("My Home")
    }
  }
}

struct ItemDetail: View {
  var item: String
  var body: some View {
    VStack {
      Image(systemName: item)
        .resizable()
        .frame(width:100, height: 100)
      Text(item)
      Spacer()
    }
  }
}

struct ItemRow: View {
  var item: String
  var body: some View {
    HStack {
      Image(systemName: item)
        .resizable()
        .frame(width:100, height: 100)
      Text(item)
      Spacer()
    }
  }
}

struct Page4_Previews: PreviewProvider {
  static var previews: some View {
    Page4()
  }
}


import SwiftUI

struct Page7: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink {
          Page1()
        } label: {
          Text("Page1")
        }
        NavigationLink {
          Page2()
        } label: {
          Text("Page2")
        }
        NavigationLink {
          Page3()
        } label: {
          Text("Page3")
        }
        NavigationLink {
          Page4()
        } label: {
          Text("Page4")
        }
      }
    }
    .navigationTitle("My Shapes")
  }
}

struct Page7_Previews: PreviewProvider {
  static var previews: some View {
    Page7()
  }
}

//
//  UIImage from URL

import SwiftUI

// Array of image url strings
let ImageArray = [
  "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/dan-osullivan1.jpg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/alumni/ari_headshot.jpg.preset.square.jpeg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/GabePattern5.jpg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/Sarah-Rothberg.jpg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/clay-shirky.jpg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/GeneralPics/katherinedillon.jpg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/alumni/pedro.galvao.jpg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/Faculty/Luisa-Pereira.jpg.preset.square.jpeg",
  "https://tisch.nyu.edu/content/dam/tisch/itp/alumni/raaziq-brown.jpg.preset.square.jpeg?",
  "https://jht1493.net/a1/skt/assets/webdb/jht/IMG_4491.JPEG",
  "https://jht1493.net/a1/skt/assets/webdb/jht/IMG_7555.JPEG",
]

// Read in an image from the array of url strings
func imageFor( index: Int) -> UIImage {
  let urlStr = ImageArray[index % ImageArray.count]
  return imageFor(string: urlStr)
}

// Read in an image from a url string
func imageFor(string str: String) -> UIImage {
  let url = URL(string: str)
  let imgData = try? Data(contentsOf: url!)
  let uiImage = UIImage(data:imgData!)
  return uiImage!
}

struct Page10: View {
  var body: some View {
    VStack {
      ForEach(0 ..< 8) { index in
        Image(uiImage: imageFor(index: index))
          .resizable()
          .frame(width:100, height: 100)
      }
    }
  }
}

struct Page10_Previews: PreviewProvider {
  static var previews: some View {
    Page1()
  }
}

// https://tisch.nyu.edu/about/directory

//
//  Item struct for more info about image

import SwiftUI

import UIKit

struct Item : Identifiable {
  let id = UUID()
  var urlStr:String
  var name:String
}

// Array of image url strings
let imageItems:[Item] = [
  Item(urlStr: imageArray[0], name:"Dan O"),
  Item(urlStr: imageArray[1], name:"Ari"),
  Item(urlStr: imageArray[2], name:"Gabe"),
  Item(urlStr: imageArray[3], name:"Sarah"),
  Item(urlStr: imageArray[4], name:"Clay"),
  Item(urlStr: imageArray[5], name:"Katherine"),
  Item(urlStr: imageArray[6], name:"Pedro"),
  Item(urlStr: imageArray[7], name:"Luisa"),
  Item(urlStr: imageArray[8], name:"Raaziq"),
  Item(urlStr: imageArray[9], name:"jht"),
  Item(urlStr: imageArray[10], name:"jht"),
]


struct Page11: View {
  var body: some View {
    VStack {
      ForEach(imageItems) { item in
        HStack {
          Image(uiImage: imageFor(string: item.urlStr))
            .resizable()
            .frame(width:100, height: 100)
          Text(item.name)
          Spacer()
        }
      }
    }
  }
}

struct Page11_Previews: PreviewProvider {
    static var previews: some View {
        Page2()
    }
}
import SwiftUI

struct Page13: View {
  var body: some View {
    List {
      ForEach(imageItems) { item in
        HStack {
          Image(uiImage: imageFor(string: item.urlStr))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:100, height: 100)
          Text(item.name)
          Spacer()
        }
      }
    }
  }
}

struct Page13_Previews: PreviewProvider {
  static var previews: some View {
    Page3()
  }
}

//
// Display a computed image in SwiftUI View
//  Uses UIGraphicsImageRenderer


//
// Display a computed image in SwiftUI View
//  Uses UIGraphicsImageRenderer

