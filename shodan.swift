//===-------------------------------------------------------===//
//
// Copyright (c) 2015-2016 Bitfyr, Inc. http://www.bitfyr.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
// associated documentation files (the "Software"), to deal in the Software without restriction, 
// including without limitation the rights to use, copy, modify, merge, publish, distribute, 
// sublicense, and or sell copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies 
// or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER // LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT // OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// 
// 
// The Shodan class interfaces with the https://api.shodan.io/
// Author: Alexandre Antonio Juca <alexandre.juca@bitfyr.com>
//===----------------------------------------------------------===//
import Glibc

struct Shodan {
  let baseUrl = "https://api.shodan.io/"
  var apiKey = "" // Could be set to nil instead
  
  init (apiKey: String) {
    self.apiKey = apiKey
    print("[DEBUG] apiKey is set to -> \(self.apiKey). ")
  }

  // Internal method that handles HTTP requests to the api
  // Requires a webservice function as param eg.("search") or ("count") and a structure containing arguments
  func request(function: String, query: String?=nil) {
      let hasQuery = query == nil
      let url: String = hasQuery ? "\(self.baseUrl)/\(function)?key=\(self.apiKey)&query=\(query)&facets=apache" : "\(self.baseUrl)/\(function)?key=\(self.apiKey)&query=\(query!)&facets=apache" ;
      print("[DEBUG] url: \(url)")
      // Unfortunately do not have access to swifts Foundation library so NSURL cannot be used
      // to perform HTTP Requests, 
      // our workaround is to use Glibc's system call to execute curl with a given endpoint url
      //system("curl -S \(url)")
  } 
  
  // Returns all services that have been on the given host IP
  func host(ip: String) -> () {
      return request("shodan/host/\(ip)", query: nil)
  }
  
  // Perform a search on shodan
  // Should return a dictionary with the search results
  func search(query: String) -> () {
      return request("shodan/host/search", query: query)
  }
  
  
  // performs a shodan search without results
  // Returns the total number of results that matched the query and any facet information.
  func count(query: String) -> () {
      return request("shodan/host/count", query: query)
  }
  
}

let shodan = Shodan(apiKey: "YOUR-API-KEY")
shodan.host("196.45.160.9")
shodan.count("apache")
