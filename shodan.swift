//===-----------------------------------------------===//
//  The WebAPI class interfaces with the shodanhq.com/api
// Author: Alexandre Antonio Juca
//===------------------------------------------------===//
import foundation

struct Shodan {
  let baseUrl = "https://api.shodan.io/"
  var apiKey = "" // Could be set to nil instead
  
  init (apiKey: String) {
    self.apiKey = apiKey    
    print("[DEBUG] apiKey is set to -> \(self.apiKey). ")
  }

  func 

}

let shodan = WebAPI(apiKey: "aX212kdsd")

