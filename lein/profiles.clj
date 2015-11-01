{:user {:plugins [[cider/cider-nrepl "0.9.1"]
                  [refactor-nrepl "1.2.0" :exclusions [org.clojure/tools.nrepl]]
                  [lein-ancient "0.6.7"]
                  [lein-plz "0.4.0-SNAPSHOT" :exclusions [[rewrite-clj] [ancient-clj]]]]
        :dependencies [[org.clojars.gjahad/debug-repl "0.3.3"]
                       ^:replace "0.2.12"]
        :plz ["/Users/paulrichardson/.lein/plzmap.edn"]}}
