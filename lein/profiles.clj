{:user {:plugins [;[cider/cider-nrepl "0.9.1"]
                  ;[refactor-nrepl "1.1.0" :exclusions [org.clojure/tools.nrepl]]
                  [lein-ancient "0.6.9"]
                  [lein-plz "0.4.0-SNAPSHOT" :exclusions [[rewrite-clj] [ancient-clj]]]]
        :dependencies [;[org.clojars.gjahad/debug-repl "0.3.3"]
                       #_[org.clojure/tools.nrepl "0.2.12"]]
        :plz ["/Users/paulrichardson/.lein/plzmap.edn"]}}
