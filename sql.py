import mysql.connector
import random

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  database="clinica_vet"
)

mycursor = mydb.cursor()

f = open("tutor.csv", "a")

numTutores = 0
while numTutores<50:
    f.write(f"{numTutores+1},{random.randrange(0, 99999999999, 3)},{random.randrange(0, 12300123, 3)},{random.randrange(0, 12300123, 3)}@{random.randrange(0, 12300123, 3)},{random.randrange(0, 9999999999999999)}\n")
    numTutores += 1

mycursor.execute("LOAD DATA INFILE 'C:/Users/8132291/Downloads/python/tutor.csv' INTO TABLE Tutor(id, cpf, nome, email, fone)")
