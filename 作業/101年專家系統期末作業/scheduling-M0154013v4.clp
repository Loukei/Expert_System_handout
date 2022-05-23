;目標:自動排課系統
;輸出:lesson (slot ID) (slot state) (slot class) (slot teacher) (slot type) (multislot time) (multislot room)
;執行順序:
;        1.開檔
;        2.複製教師的喜好時數(初始化)
;        3.選擇喜好時數最少的老師，優先排完他的喜好時數，直到喜好時數沒有連三節，或是剩下時段不能排課為止
;        4.選擇下一位喜好時數最低的老師，回到step3
;        5.剩下的未排完課程再排入，此時跟老師的喜好時數無關
;        6.關檔列印結果

;====================================MODULE ;MAIN=================================================
(defmodule MAIN (export deftemplate teacher class classroom lesson favorite-time refuse-time alltime) )
(deftemplate MAIN::teacher (slot ID) (slot weight))
(deftemplate MAIN::class (slot ID))
(deftemplate MAIN::classroom (slot ID) (slot type))
(deftemplate MAIN::lesson (slot ID) (slot state) (slot class) (slot teacher) (slot type) (multislot time) (multislot room)) 
(deftemplate MAIN::favorite-time (slot teacher) (multislot time))
(deftemplate MAIN::refuse-time (slot teacher) (multislot time))

(deffacts MAIN::initial
  (alltime 101 102 103 104 105 106 107 108 109 110 
	   201 202 203 204 205 206 207 208 209 210
	   301 302 303 304 305 306 307 308 309 310
	   401 402 403 404 405 406 407 408 409 410
	   501 502 503 504 505 506 507 508 509 510)
  ;所有的上課時間
  (teacher (ID 61001) (weight 0))
  (teacher (ID 61002) (weight 0))
  (teacher (ID 61003) (weight 0))
  (teacher (ID 61004) (weight 0))
  (teacher (ID 61005) (weight 0))
  (teacher (ID 61006) (weight 0))
  (teacher (ID 61007) (weight 0))
  (teacher (ID 61008) (weight 0))
  (teacher (ID 61009) (weight 0))
  (teacher (ID 61010) (weight 0))
  (teacher (ID 61011) (weight 0))
  (teacher (ID 61012) (weight 0))
  ;教師
  (class (ID csie96))
  (class (ID csie97))
  (class (ID csie98))
  (class (ID csie99))
  ;班級
  (classroom (ID 31503) (type laboratory))
  (classroom (ID 32101) (type computer))
  (classroom (ID 31304) (type lecture))
  (classroom (ID 31305) (type lecture))
  (classroom (ID 31306) (type lecture))
  ;教室
  (favorite-time (teacher 61001) (time 202 203 302 303 402 403))
  (refuse-time (teacher 61001) (time 105 106 107 205 206 207 305 306 307 405 406 407 505 506 507))
  (favorite-time (teacher 61002) (time 105 106 205 206 305 306 405 406 505 506))
  (refuse-time (teacher 61002) (time 101 103 109 201 203 209 301 303 309 401 403 409 501 503 509))
  (favorite-time (teacher 61003) (time 204 205 206 304 305 306 404 405 406))
  (refuse-time (teacher 61003) (time 101 102 103 104 105 106 107 108 502 505 506 507 508 509 510))
  (favorite-time (teacher 61004) (time 403 404 405 406 503 504 505 506))
  (refuse-time (teacher 61004) (time 101 102 103 106 109 201 202 203 206 209 301 302 303 306 309))
  (favorite-time (teacher 61005) (time 103 104 105 203 204 205 303 304 305 403 404 405))
  (refuse-time (teacher 61005) (time 107 108 109 207 208 209 307 308 309 407 408 409 507 508 509))
  (favorite-time (teacher 61006) (time 105 106 205 206 305 306 405 406 505 506))
  (refuse-time (teacher 61006) (time 101 103 109 201 203 209 301 303 309 401 403 409 501 503 509))
  (favorite-time (teacher 61007) (time 205 206 207 305 306 307 405 406 407))
  (refuse-time (teacher 61007) (time 101 103 109 201 203 209 301 303 309 401 403 409 501 503 509))
  (favorite-time (teacher 61008) (time 205 206 207 305 306 307 405 406 407))
  (refuse-time (teacher 61008) (time 101 102 110 201 202 210 301 302 310 401 402 410 501 502 510))
  (favorite-time (teacher 61009) (time 206 207 208 306 307 308 406 407 408))
  (refuse-time (teacher 61009) (time 103 106 109 201 202 210 301 302 310 401 402 410 503 506 509))
  (favorite-time (teacher 61010) (time 205 206 207 305 306 307 405 406 407))
  (refuse-time (teacher 61010) (time 101 103 109 201 203 209 301 303 309 401 403 409 501 503 509))
  (favorite-time (teacher 61011) (time 102 103 202 203 302 303 402 403 502 503))
  (refuse-time (teacher 61011) (time 108 109 110 208 209 210 308 309 310 408 409 410 508 509 510))
  (favorite-time (teacher 61012) (time 204 205 206 207 404 405 406 407))
  (refuse-time (teacher 61012) (time 101 102 103 106 108 301 302 303 304 501 502 503 506 508 510))
  ;教師的喜好/拒絕時間
  (lesson (ID 01) (state 0) (class csie96) (teacher 61001) (type laboratory) (time) (room))
  (lesson (ID 02) (state 0) (class csie96) (teacher 61001) (type lecture) (time) (room))
  (lesson (ID 03) (state 0) (class csie96) (teacher 61002) (type lecture) (time) (room))
  (lesson (ID 04) (state 0) (class csie96) (teacher 61002) (type lecture) (time) (room))
  (lesson (ID 05) (state 0) (class csie96) (teacher 61003) (type laboratory) (time) (room))
  (lesson (ID 06) (state 0) (class csie96) (teacher 61005) (type computer) (time) (room))
  (lesson (ID 07) (state 0) (class csie96) (teacher 61006) (type computer) (time) (room))
  (lesson (ID 08) (state 0) (class csie96) (teacher 61007) (type lecture) (time) (room))
  (lesson (ID 09) (state 0) (class csie96) (teacher 61008) (type lecture) (time) (room))
  (lesson (ID 10) (state 0) (class csie96) (teacher 61010) (type lecture) (time) (room))
  (lesson (ID 11) (state 0) (class csie97) (teacher 61001) (type lecture) (time) (room))
  (lesson (ID 12) (state 0) (class csie97) (teacher 61004) (type lecture) (time) (room))
  (lesson (ID 13) (state 0) (class csie97) (teacher 61005) (type lecture) (time) (room))
  (lesson (ID 14) (state 0) (class csie97) (teacher 61006) (type lecture) (time) (room))
  (lesson (ID 15) (state 0) (class csie97) (teacher 61007) (type computer) (time) (room))
  (lesson (ID 16) (state 0) (class csie97) (teacher 61010) (type lecture) (time) (room))
  (lesson (ID 17) (state 0) (class csie97) (teacher 61010) (type laboratory) (time) (room))
  (lesson (ID 18) (state 0) (class csie97) (teacher 61011) (type laboratory) (time) (room))
  (lesson (ID 19) (state 0) (class csie97) (teacher 61012) (type lecture) (time) (room))
  (lesson (ID 20) (state 0) (class csie97) (teacher 61012) (type computer) (time) (room))
  (lesson (ID 21) (state 0) (class csie98) (teacher 61003) (type lecture) (time) (room))
  (lesson (ID 22) (state 0) (class csie98) (teacher 61004) (type lecture) (time) (room))
  (lesson (ID 23) (state 0) (class csie98) (teacher 61005) (type laboratory) (time) (room))
  (lesson (ID 24) (state 0) (class csie98) (teacher 61006) (type laboratory) (time) (room))
  (lesson (ID 25) (state 0) (class csie98) (teacher 61006) (type lecture) (time) (room))
  (lesson (ID 26) (state 0) (class csie98) (teacher 61008) (type lecture) (time) (room))
  (lesson (ID 27) (state 0) (class csie98) (teacher 61009) (type computer) (time) (room))
  (lesson (ID 28) (state 0) (class csie98) (teacher 61009) (type lecture) (time) (room))
  (lesson (ID 29) (state 0) (class csie98) (teacher 61011) (type computer) (time) (room))
  (lesson (ID 30) (state 0) (class csie98) (teacher 61012) (type lecture) (time) (room))
  (lesson (ID 31) (state 0) (class csie99) (teacher 61001) (type computer) (time) (room))
  (lesson (ID 32) (state 0) (class csie99) (teacher 61002) (type computer) (time) (room))
  (lesson (ID 33) (state 0) (class csie99) (teacher 61003) (type lecture) (time) (room))
  (lesson (ID 34) (state 0) (class csie99) (teacher 61004) (type lecture) (time) (room))
  (lesson (ID 35) (state 0) (class csie99) (teacher 61005) (type laboratory) (time) (room))
  (lesson (ID 36) (state 0) (class csie99) (teacher 61007) (type laboratory) (time) (room))
  (lesson (ID 37) (state 0) (class csie99) (teacher 61008) (type lecture) (time) (room))
  (lesson (ID 38) (state 0) (class csie99) (teacher 61009) (type lecture) (time) (room))
  (lesson (ID 39) (state 0) (class csie99) (teacher 61011) (type lecture) (time) (room))
  (lesson (ID 40) (state 0) (class csie99) (teacher 61012) (type lecture) (time) (room))
  ;開課時間
  (phase statrt);是否執行過一次的標準
)

;開檔
(defrule MAIN::Openfile
 (declare (salience 100))
 =>
 (open "result-M0154013v4.txt" mydata "w")
 (printout t "open file result-M0154013v4.txt" crlf)
)

;流程控制
(defrule MAIN::Controlrule
 (declare (salience 80))
 ?f1 <- (phase statrt)
 =>
 (retract ?f1);避免執行過又回來再跑一次
 (focus FAVORITE-SCHEDULE SCHEDULING PRINT)
)

;關檔
(defrule MAIN::CloseFile
 (declare (salience -50) )
 =>
 (close result-M0154013v4.txt)
 (printout t "close file result-M0154013v4.txt" crlf)
)
;====================================MODULE ;FAVORITE-SCHEDULE=================================================
(defmodule FAVORITE-SCHEDULE (import MAIN deftemplate teacher class classroom lesson favorite-time refuse-time alltime) )
(deftemplate FAVORITE-SCHEDULE::favorite (slot teacher) (multislot time) (slot conform));代替favorite-time進行刪除

;複製favorite-time
(defrule FAVORITE-SCHEDULE::Copyfavorite-time
 (declare (salience 100))
 (favorite-time (teacher ?teacher) (time $?time))
 =>
 (assert (favorite (teacher ?teacher) (time $?time) (conform 1)));conform(1)表示此教師的剩餘喜好時間仍能再拿來排課
)

;選擇喜好時數最少的老師，並且此教師剩餘三節以上喜好時間，而且是不會衝堂的
(defrule FAVORITE-SCHEDULE::Choose-teacher
 (teacher (ID ?teacher1) (weight ?weight1));選擇一位教師並且剩餘3個以上喜好時間
 (favorite (teacher ?teacher1) (time $? ?t11 ?t12 ?t13&:(= (+ ?t11 2) ?t13) $?) (conform 1));該教師剩餘三節以上連續的喜好時間
 (not (and (teacher (ID ?teacher2) (weight ?weight2))
           (favorite (teacher ?teacher2) (time $? ?t21 ?t22 ?t23&:(= (+ ?t21 2) ?t23) $?) (conform 1))
           (test (> ?weight1 ?weight2))
      )
 )
 =>
 (assert (choose-teacher ?teacher1) )
 ;(printout t "(choose-teacher "?teacher1")" crlf);debug
)

;被選中的教師來進入排課
(defrule FAVORITE-SCHEDULE::favorite-scheduling
 ?choose <- (choose-teacher ?teacher);選中的教師ID 
 ?f1 <- (lesson (ID ?) (state 0) (class ?class) (teacher ?teacher) (type ?type) (time) (room));任選他的一課程
 ?f2 <- (teacher (ID ?teacher) (weight ?weight))
 ?f3 <- (favorite (teacher ?teacher) (time $?first ?t1 ?t2 ?t3&:(= (+ ?t1 2) ?t3) $?rest) (conform 1));從剩餘的喜好時間來挑
 (classroom (ID ?classroom) (type ?type))
 (not (lesson (state 1) (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (class ?class) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (time $? ?t1|?t2|?t3 $?) (room ?classroom ?classroom ?classroom)))
 =>
 (retract ?choose)
 (modify ?f1 (state 1) (time ?t1 ?t2 ?t3) (room ?classroom ?classroom ?classroom))
 (modify ?f2 (weight (+ ?weight 3)));weight+=3
 (modify ?f3 (time $?first $?rest))
 (printout t "(favorite (teacher "?teacher") (time "$?first $?rest"))" crlf);debug
)

;被選中的教師有足夠喜好時間，但是剩餘的課卻都不能排，必須剃除候選
(defrule FAVORITE-SCHEDULE::favorite-scheduling-Out
 ?choose <- (choose-teacher ?teacher);選中的教師ID
 ?favorite <- (favorite (teacher ?teacher) (time $?first ?t1 ?t2 ?t3&:(= (+ ?t1 2) ?t3) $?rest) (conform 1));從剩餘的喜好時間來挑 
 (not (and (lesson (ID ?) (state 0) (class ?class) (teacher ?teacher) (type ?type) (time) (room))
           (classroom (ID ?classroom) (type ?type))
           (not (lesson (state 1) (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
           (not (lesson (state 1) (class ?class) (time $? ?t1|?t2|?t3 $?)))
           (not (lesson (state 1) (time $? ?t1|?t2|?t3 $?) (room ?classroom ?classroom ?classroom)))
      )
 )
 =>
 (retract ?choose)
 (modify ?favorite (conform 0));此教師修改成不能排入
)
;====================================MODULE ;SCHEDULING=================================================
(defmodule SCHEDULING (import MAIN deftemplate teacher class classroom lesson favorite-time refuse-time alltime) )

;排剩下只有連2堂是favoritetime的課
(defrule SCHEDULING::favorite-scheduling-rest-right
 (declare (salience 150))
 ?f1 <- (lesson (ID ?select) (state 0) (class ?class) (teacher ?teacher) (type ?type) (time) (room))
 (teacher (ID ?teacher) (weight ?))
 (favorite-time (teacher ?teacher) (time $? ?t1 ?t2&:(= (+ ?t1 1) ?t2) $?));從favorite-time選連續兩節
 (classroom (ID ?classroom) (type ?type))
 (alltime $? ?t3&:(= (+ ?t1 2) ?t3) $?); t3 = t1 + 2
 (not (refuse-time (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (class ?class) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (time $? ?t1|?t2|?t3 $?) (room ?classroom ?classroom ?classroom)))
 =>
 (modify ?f1 (state 1) (time ?t1 ?t2 ?t3) (room ?classroom ?classroom ?classroom))
 ;(printout t "(lesson (ID "?select") (state 1) (class "?class") (teacher "?teacher") (type "?type") 
              ;(time "?t1 ?t2 ?t3") (room "?classroom ?classroom ?classroom"))" crlf);debug
)

(defrule SCHEDULING::favorite-scheduling-rest-left
 (declare (salience 150))
 ?f1 <- (lesson (ID ?select) (state 0) (class ?class) (teacher ?teacher) (type ?type) (time) (room))
 (teacher (ID ?teacher) (weight ?))
 (favorite-time (teacher ?teacher) (time $? ?t1 ?t2&:(= (+ ?t1 1) ?t2) $?));從favorite-time選連續兩節
 (classroom (ID ?classroom) (type ?type))
 (alltime $? ?t3&:(= (- ?t1 1) ?t3) $?);t3 = t1-1
 (not (refuse-time (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (class ?class) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (time $? ?t1|?t2|?t3 $?) (room ?classroom ?classroom ?classroom)))
 =>
 (modify ?f1 (state 1) (time ?t3 ?t1 ?t2) (room ?classroom ?classroom ?classroom))
 ;(printout t "(lesson (ID "?select") (state 1) (class "?class") (teacher "?teacher") (type "?type") 
              ;(time "?t1 ?t2 ?t3") (room "?classroom ?classroom ?classroom"))" crlf);debug
)

;排完剩下可以連3堂都不是拒絕時間的課
(defrule SCHEDULING::scheduling-3
 (declare (salience 100))
 ?f1 <- (lesson (ID ?select) (state 0) (class ?class) (teacher ?teacher) (type ?type) (time) (room))
 (teacher (ID ?teacher) (weight ?))
 (classroom (ID ?classroom) (type ?type))
 (alltime $? ?t1 ?t2 ?t3&:(= (+ ?t1 2) ?t3) $?)
 (not (refuse-time (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (class ?class) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (time $? ?t1|?t2|?t3 $?) (room ?classroom ?classroom ?classroom)))
 =>
 (modify ?f1 (state 1) (time ?t1 ?t2 ?t3) (room ?classroom ?classroom ?classroom))
 ;(printout t "(lesson (ID "?select") (state 1) (class "?class") (teacher "?teacher") (type "?type") 
              ;(time "?t1 ?t2 ?t3") (room "?classroom ?classroom ?classroom"))" crlf);debug
)

;只要兩堂不是refusetime
(defrule SCHEDULING::scheduling-2
 (declare (salience 80))
 ?f1 <- (lesson (ID ?select) (state 0) (class ?class) (teacher ?teacher) (type ?type) (time) (room))
 (teacher (ID ?teacher) (weight ?))
 (classroom (ID ?classroom) (type ?type))
 (alltime $? ?t1 ?t2 ?t3&:(= (+ ?t1 2) ?t3) $?)
 (or (not (refuse-time (teacher ?teacher) (time $? ?t1|?t2 $?)));t3可以是refusetime
     (not (refuse-time (teacher ?teacher) (time $? ?t1|?t3 $?)));t2可以是refusetime
     (not (refuse-time (teacher ?teacher) (time $? ?t2|?t3 $?)));t1可以是refusetime
 )
 (not (lesson (state 1) (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (class ?class) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (time $? ?t1|?t2|?t3 $?) (room ?classroom ?classroom ?classroom)))
 =>
 (modify ?f1 (state 1) (time ?t1 ?t2 ?t3) (room ?classroom ?classroom ?classroom))
)

;只要一堂不是refusetime
(defrule SCHEDULING::scheduling-1
 (declare (salience 50))
 ?f1 <- (lesson (ID ?select) (state 0) (class ?class) (teacher ?teacher) (type ?type) (time) (room))
 (teacher (ID ?teacher) (weight ?))
 (classroom (ID ?classroom) (type ?type))
 (alltime $? ?t1 ?t2 ?t3&:(= (+ ?t1 2) ?t3) $?)
 (or (not (refuse-time (teacher ?teacher) (time $? ?t1 $?)));t2 t3可以是refusetime
     (not (refuse-time (teacher ?teacher) (time $? ?t2 $?)));t1 t3可以是refusetime
     (not (refuse-time (teacher ?teacher) (time $? ?t3 $?)));t1 t2可以是refusetime
 )
 (not (lesson (state 1) (teacher ?teacher) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (class ?class) (time $? ?t1|?t2|?t3 $?)))
 (not (lesson (state 1) (time $? ?t1|?t2|?t3 $?) (room ?classroom ?classroom ?classroom)))
 =>
 (modify ?f1 (state 1) (time ?t1 ?t2 ?t3) (room ?classroom ?classroom ?classroom))
)

;====================================MODULE ;PRINT=================================================
(defmodule PRINT (import MAIN deftemplate teacher class classroom lesson favorite-time refuse-time alltime) )

(defrule PRINT::Output
 (declare (salience 50)) 
 (lesson (ID ?id) (state ?state) (class ?class) (teacher ?teacher) (type ?type) (time $?time) (room $?room)) 
=>
 (printout mydata "(lesson (ID "?id") (state "?state") (class "?class") (teacher "?teacher") (type "?type") (time "(implode$ $?time)") (room "(implode$ $?room)")) " crlf)
)