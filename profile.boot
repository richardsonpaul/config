(set-env!
 :dependencies '[[adzerk/boot-cljs "1.7.228-1"]
                 [adzerk/boot-test "1.1.2" :scope "test"]
                 [adzerk/boot-reload "0.4.12"]
                 [adzerk/boot-cljs-repl "0.3.3"]
                 [org.clojure/clojure "1.8.0"]
                 [org.clojure/clojurescript "1.7.170"]
                 [com.cemerick/piggieback "0.2.1"]
                 [weasel "0.7.0"]
                 [pandeiro/boot-http "0.7.6"]
                 [org.clojure/tools.nrepl "0.2.12"]
                 [javax.servlet/servlet-api "2.5"]])

(require '[adzerk.boot-cljs :refer [cljs]]
         '[adzerk.boot-reload :refer [reload]]
         '[adzerk.boot-cljs-repl :refer [cljs-repl start-repl]]
         '[adzerk.boot-test :refer :all]
         '[pandeiro.boot-http :refer [serve]])

(deftask term
  "Auto-build cljs live reloading server"
  []
  (comp
   (serve :resource-root "target"
          :reload true
          :handler 'modern-cljs.remotes/app)
   (watch)
   (reload)
   (cljs-repl)
   (cljs)
   (target :dir #{"target"})))

(deftask cider "CIDER profile"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat '[[cider/cider-nrepl "0.13.0"]
                  [refactor-nrepl "2.2.0"]])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  refactor-nrepl.middleware/wrap-refactor]))

(deftask dev []
  (cider)
  (term))

(deftask a-out
  "Executes build.boot for side effects"
  []
  identity)
