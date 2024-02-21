(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package templatel :ensure t)
(use-package htmlize
  :ensure t
  :config
  (setq org-html-htmlize-output-type 'css))

(require 'weblorg)

(weblorg-site
 :template-vars '(("site_name" . "This week I learned...")
                  ("site_owner" . "owner@mail.com (owner)")
                  ("site_description" . "A small blog about things I learned this week."))
 :theme nil)

(setq weblorg-default-url "http://localhost:8080")


;; route for rendering each post
(weblorg-route
 :name "posts"
 :input-pattern "posts/*.org"
 :template "post.html"
 :output "output/posts/{{ slug }}.html"
 :url "/posts/{{ slug }}.html")

;; route for rendering the index page with a list of posts
(weblorg-route
 :name "index"
 :input-pattern "posts/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "blog.html"
 :output "output/index.html"
 :url "/")

;; route for rendering each page
(weblorg-route
 :name "pages"
 :input-pattern "pages/*.org"
 :template "page.html"
 :output "output/{{ slug }}.html"
 :url "/{{ slug }}.html")

;; generate rss feed
(weblorg-route
 :name "feed"
 :input-pattern "posts/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "feed.xml"
 :output "output/feed.xml"
 :url "/feed.xml")

;; route for static assets that also copies files to output directory
(weblorg-copy-static
 :output "output/static/{{ file }}"
 :url "/static/{{ file }}")


(weblorg-export)
