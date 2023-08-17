import CoreLocation
import UIKit

class LocationServicesVC: UIViewController, CLLocationManagerDelegate {
    private lazy var locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.delegate = self
        location.requestWhenInUseAuthorization()
        return location
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.startUpdatingLocation()

        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.33, longitude: -122.83), radius: 500, identifier: "home")

        locationManager.startMonitoring(for: region)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude), Speed: \(location.speed)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region.identifier == "home" {
            print("Entered the home region!")

            let alertController = UIAlertController(title: "Home Region", message: "You entered the home region.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}
