สำหรับ backend รันบน local รันผ่าน visual studio version 2019 ขึ้นไป
ติดตั้ง .net sdk  .net framwork 4.6.1
เปิดด้วยไฟล์ .sln
เมื่อลงแล้วและเปิด project แล้ว ติดตั้ง Pakget  ด้วย Nuget Pakget  สำหรับ ติดตั้ง Newtonsoft.Json

Database
ใช้ ssms ให้สร้าง DB เป็น local หรือ บนเครื่อง server สร้าง DB ชื่อ WongnokDB 
หลังจากนั้น รันไฟล์ Script Shema (Table , Stored procedure)  ชื่อว่า wongnok.sql ใน folder doc


แล้ว เปลี่ยน connection ที่ backend ไฟล์ที่ชื่อว่า ConnectionCommon.cs
parameter ชื่อว่า _DBConnString

เมื่อเชื่อต่อฐานข้อมูลเรียบร้อยแล้ว กดรัน หลังจากนั้นนำ url ไปแก้ไข connection endpoint API ที่ไฟล์ controller ของ frontend
ให้ทำการรันอาไว้ หาก หยุดหรือปิดโปรแกรม frontend จะไม่สามารถเชื่อมต่อได้
