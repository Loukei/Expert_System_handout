;���z�������Y
;�H�W
(deftemplate person (slot name) (slot sex) )
;�ˤl���Y
(deftemplate parent-children (multislot parent) (multislot children) )
;�ҩd���Y
(deftemplate pair (slot husband) (slot wife) )
;�S�̩n�f���Y
(deftemplate brother-sister (multislot sibling) )
;�d�ߨƹ�
(deftemplate query (slot name) (slot subject) )
;��l��
(deffacts initial
 (person (name john) (sex male) )
 (person (name peter) (sex male) )
 (person (name david) (sex male) )
 (person (name joe) (sex male) )
 (person (name kevin) (sex male) )
 (person (name mary) (sex female) )
 (person (name sue) (sex female) )
 (person (name linda) (sex female) )
 (person (name sherry) (sex female) )

 (pair (husband john) (wife sue))
 (pair (husband david) (wife linda))
 (pair (husband peter) (wife sherry))

 (parent-children (parent john sue) (children marry kevin))
 (parent-children (parent peter sherry) (children john linda))
 (parent-children (parent david linda) (children joe))

 (query (name mary) (subject kevin))
 (query (name sue) (subject kevin))
 (query (name peter) (subject kevin))
 (query (name david) (subject kevin))
 (query (name linda) (subject kevin))
 (query (name joe) (subject kevin))
)

;����
(defrule grandfather
 	(query (name ?p1) (subject ?p2))
 	(person (name ?p1) (sex male))
 	(parent-children (parent $? ?p3 $? ?p4 $?) (children $? ?p2 $?));p3 p4��p2����
 	(or 
    	   (parent-children (parent $? ?p1 $?) (children $? ?p3 $?));p3�����Op1
    	   (parent-children (parent $? ?p1 $?) (children $? ?p4 $?));p4--------
 	) 
	=>
 	(printout t ?p1 " is " ?p2 " grandfather" crlf)
)

;����
(defrule mother
 	(query (name ?p1) (subject ?p2))
 	(parent-children (parent $? ?p1 $?) (children $? ?p2 $?))
 	(person (name ?p1) (sex female))
 	=>
 	(printout t ?p1 " is " ?p2 " mother " crlf)
)

;�S�̩n�f
(defrule sibling
        (parent-children (parent $?) (children $?p1) )
 	=>
        (assert (brother-sister (sibling $?p1)) )
)

;�n�f
(defrule sister
 	(query (name ?p1) (subject ?p2))
 	(person (name ?p1) (sex female))
	(or
	 (brother-sister (children $? ?p1 $? ?p2 $?))
	 (brother-sister (children $? ?p2 $? ?p1 $?))
	)
 	=>
 	(printout t ?p1 " is " ?p2 " sister " crlf)
)

;����
(defrule aunt
 	(query (name ?p1) (subject ?p2))
	(person (name ?p1) (sex female))
 	(parent-children (parent ?p3 ?p4) (children $? ?p2 $?)) ;?p3,?p4������
 	(or
   	  (or
	     (brother-sister (sibling $? ?p1 $? ?p3 $?))
	     (brother-sister (sibling $? ?p3 $? ?p1 $?))
	  )

   	  (or
	     (brother-sister (sibling $? ?p1 $? ?p4 $?))
	     (brother-sister (sibling $? ?p4 $? ?p1 $?))
	   )
  	)
 =>
 (printout t ?p1 " is " ?p2 " aunt " crlf)
)

;���
(defrule cousin
 	(query (name ?p1) (subject ?p2))
	(person (name ?p1) (sex male))
 	(parent-children (parent ?p3 ?p4) (children $? ?p2 $?)) ;?p3,?p4��?p2����
	(parent-children (parent ?p5 ?p6) (children $? ?p1 $?)) ;?p5,?p6��?p1����
	(or
	 (brother-sister (sibling $? ?p3 $? ?p5 $?));?p3��?p5�O�_��sibling
	 (brother-sister (sibling $? ?p5 $? ?p3 $?))
	 (brother-sister (sibling $? ?p3 $? ?p6 $?));?p3��?p6�O�_��sibling
	 (brother-sister (sibling $? ?p6 $? ?p3 $?))
	 (brother-sister (sibling $? ?p4 $? ?p5 $?));?p4��?p5�O�_��sibling
	 (brother-sister (sibling $? ?p5 $? ?p4 $?))
	 (brother-sister (sibling $? ?p4 $? ?p6 $?));?p4��?p6�O�_��sibling
	 (brother-sister (sibling $? ?p6 $? ?p4 $?))
	)
 =>
 (printout t ?p1 " is " ?p2 " cousin " crlf)
)