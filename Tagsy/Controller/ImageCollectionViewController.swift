
import UIKit

private let reuseIdentifier = "imageCell"

class ImageCollectionViewController: UICollectionViewController {
  
  let imagePicker = UIImagePickerController()
  var imageLoaderViewController: ImageLoaderViewController?
  var uploadedImages: [UploadedImage] = []
  
  @IBAction func tappedPlusButton(_ sender: UIBarButtonItem) {
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    imagePicker.delegate = self
    // Do any additional setup after loading the view.
  }
  
  
  // MARK: UICollectionViewDataSource
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return uploadedImages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    let imageview: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100));
    imageview.image = uploadedImages[indexPath.row].image
    
    cell.contentView.addSubview(imageview)
    // Configure the cell
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let loaderNC = segue.destination as? UINavigationController,
          let loaderVC = loaderNC.topViewController as? ImageLoaderViewController else {return}
    imageLoaderViewController = loaderVC
    imageLoaderViewController?.delegate = self
    loaderVC.uploadedImage = uploadedImages.last
    return
  }
}
