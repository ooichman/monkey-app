package main

import (
 "fmt"
 "io/ioutil"
 "net/http"
 "os"
 "log" 
 "github.com/golang/glog"
)

type Page struct {
 Title string
 Body  []byte
}

func loadPage(filename string) (*Page, error) {
 body, err := ioutil.ReadFile(filename)
 if err != nil {
  return nil, err
 }

return &Page{Title: filename, Body: body}, nil
}

// HelloServer responds to requests with the given URL path.
func HelloServer(w http.ResponseWriter, r *http.Request) {

fmt.Fprintf(w, "Hello, you requested: %s\n", r.URL.Path)
  glog.Info("Received request for path: %s", r.URL.Path)
}

func ReadFile(w http.ResponseWriter, r *http.Request) {
 h_workdir, found := os.LookupEnv("HELLO_WORKDIR")
 if !found {
  h_workdir = "/opt/app-root/"
 }

file_name, f_found := os.LookupEnv("HELLO_FILENAME")
 if !f_found {
  file_name = "index.html"
 }

h_workdir += "/" + file_name

p, err := loadPage(h_workdir)

if err != nil {
  p = &Page{Title: file_name}
 }

h_workdir += "index.html"
 fmt.Fprintf(w, "<h1>%s</h1><div>%s</div>", p.Title, p.Body)
 glog.Info("parsing the HTML file...")
}

func main() {
 port, found := os.LookupEnv("GO_PORT")
 if !found {
  port = "8080"
 }

http.HandleFunc("/api/", HelloServer)
 http.HandleFunc("/readfile/", ReadFile)

log.Printf("Starting to listen on port %s", port)
 log.Fatal(http.ListenAndServe(":"+port, nil))
}
