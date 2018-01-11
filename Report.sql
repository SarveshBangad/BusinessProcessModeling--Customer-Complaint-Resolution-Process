/*Report - 1*/
/*Get count of complaints across feedback ratings*/
SELECT Feedback_Rating, Count(Distinct Complaint_Id) "Complaint_Count"
FROM Complaint_Feedback_T5
GROUP BY Feedback_Rating
ORDER BY Feedback_Rating;

/*Report-2*/
/*Get the complaints logged by each customer*/
SELECT cu.Customer_Id, cu.Customer_First_Name, cu.Customer_Last_Name, Count(Distinct c.Complaint_Id) "Compliant_Count"
FROM Complaint_T5 c, Order_Line_T5 OL, Order_T5 o, Customer_T5 cu
WHERE c.Order_Line_Id = ol.Order_Line_Id AND OL.Order_Id = o.Order_Id AND o.Customer_Id = cu.Customer_Id
GROUP BY cu.Customer_Id, cu.Customer_First_Name, cu.Customer_Last_Name;


/*Report - 3*/
/*As per the existing process, we had counts of complaints at "Product Category" level. We introduced "Severity" for each complaint 
which would help to identify critical complaints which would need immediate attention */
SELECT q.Product_Category, r.Severity, Count(DISTINCT r.Complaint_Id) "Complaint_Count"
FROM Product_T5 q
JOIN (SELECT o.Product_Id, c.Severity, c.Complaint_Id   
FROM Complaint_T5 c
JOIN Order_Line_T5 o ON c.Order_Line_Id = o.Order_Line_Id
) r
ON r.Product_Id = q.Product_Id
GROUP BY q.Product_Category, r.Severity
Order By q.Product_Category, r.Severity DESC;