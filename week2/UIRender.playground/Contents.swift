
import UIKit

// Read in an image from a url string
func imageFor(_ str: String) -> UIImage {
    let url = URL(string: str)
    let imgData = try? Data(contentsOf: url!)
    let uiImage = UIImage(data:imgData!)
    return uiImage!
}

// Andy Warhol, Marilyn Monroe
let u1 = "https://images.masterworksfineart.com/product/marilyn-monroe-marilyn-1967-10/marilyn-28.jpg"
let ui1 = imageFor(u1)

// Marilyn Monroe
let u2 = "https://th.bing.com/th/id/R.1d5eaf670baf0893a2518babf1038c1b?rik=uB8HqXGQlFnVeQ&riu=http%3a%2f%2fwww.popdam.org%2fblog%2fwp-content%2fuploads%2f2012%2f09%2fwarhol-marilyn.jpg&ehk=8oHZbj4H1%2bfR9ZDTzjV14oo7fX5mQE4rpWcYu8OYnJI%3d&risl=&pid=ImgRaw&r=0"
let ui2 = imageFor(u2)

let u3 = "https://th.bing.com/th/id/OIP.9EnkCtmvYlYJM-X4LrPzMQHaHW?pid=ImgDet&rs=1"
let ui3 = imageFor(u3)

let u4 = "https://th.bing.com/th/id/OIP.1qnBH20ZaIQbVv0vxjvnZQHaIt?pid=ImgDet&rs=1"
let ui4 = imageFor(u4)

let sz = CGSize(width: 1024, height: 1024)
let renderer = UIGraphicsImageRenderer(size: sz)

let image = renderer.image { (context) in
    ui1.draw(in: CGRect(x: 0, y: 0, width: 512, height: 512))
    ui2.draw(in: CGRect(x: 512, y: 0, width: 512, height: 512))
    ui3.draw(in: CGRect(x: 0, y: 512, width: 512, height: 512))
    ui4.draw(in: CGRect(x: 512, y: 512, width: 512, height: 512))
}

image

