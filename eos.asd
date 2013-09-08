;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; indent-tabs-mode: nil -*-

(asdf:defsystem :Eos
  :author "Adlai Chandrasekhar"
  :license "MIT"
  :components ((:module "src"
                        :components
                        ((:file "package")
                         (:file "utils"   :depends-on ("package"))
                         (:file "classes" :depends-on ("package"))
                         (:file "check"   :depends-on ("utils"))
                         (:file "test"    :depends-on ("classes"))
                         (:file "explain" :depends-on ("classes" "check"))
                         (:file "suite"   :depends-on ("test" "utils"))
                         (:file "run"     :depends-on ("suite" "check"))))))

(asdf:defsystem :Eos-tests
  :author "Adlai Chandrasekhar"
  :license "MIT"
  :depends-on (:Eos)
  :components ((:module "tests"
                         :components
                         ((:file "suite")
                          (:file "tests" :depends-on ("suite"))))))

(defmethod asdf:operate :before ((op asdf:load-op)
                                 (system (eql (asdf:find-system :Eos)))
                                 &rest proclamations)
  (declare (ignore proclamations))
  (format t "~2&************************~@
                ** Eos is deprecated! **~@
                **   See README.mkdn  **~@
                ************************~%"))

(defmethod asdf:perform ((op asdf:test-op) (system (eql (asdf:find-system :Eos))))
  (format t "~2&*******************~@
                ** Loading tests **~@
                *******************~%")
  (asdf:oos 'asdf:load-op :Eos-tests)
  (asdf:oos 'asdf:test-op :Eos-tests))
