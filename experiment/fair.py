import csv

def printme( h1, h3, h5, optimal, filename):
  f = open(filename, 'w')
  for row in h1:
    baseTime = float(row[0])

    x1 = (int(row[11]) * 8.0 / 1024)/optimal
  
    x3 = None
    x5 = None
    offset = None
  
    found = 100.0
    for r in h3:
      offset = abs(baseTime-float(r[0]))
      if offset < found:
        found = offset
        x3 = (int(r[11]) * 8.0 / 1024)/optimal

    found = 100.0
    for r in h5:
      offset = abs(baseTime-float(r[0]))
      if offset < found:
        found = offset
        x5 = (int(r[11]) * 8.0 / 1024)/optimal
    #Jain's fairness index
    fairness = pow(x1 + x3 + x5, 2)/(3 * (pow(x1, 2) + pow(x3, 2) + pow(x5, 2)))
    f.write(str(baseTime) +" "+ str(fairness) + "\n")
#    print baseTime, fairness
  f.close()


h1_inigo = list(csv.reader(open("h1-inigo.data"), delimiter=" "))
h3_inigo = list(csv.reader(open("h3-inigo.data"), delimiter=" "))
h5_inigo = list(csv.reader(open("h5-inigo.data"), delimiter=" "))

#h1_cdg = list(csv.reader(open("h1-cdg.data"), delimiter=" "))
#h3_cdg = list(csv.reader(open("h3-cdg.data"), delimiter=" "))
#h5_cdg = list(csv.reader(open("h5-cdg.data"), delimiter=" "))

h1_im = list(csv.reader(open("h1-im.data"), delimiter=" "))
h3_im = list(csv.reader(open("h3-im.data"), delimiter=" "))
h5_im = list(csv.reader(open("h5-im.data"), delimiter=" "))

h1_xcp = list(csv.reader(open("h1-xcp.data"), delimiter=" "))
h3_xcp = list(csv.reader(open("h3-xcp.data"), delimiter=" "))
h5_xcp = list(csv.reader(open("h5-xcp.data"), delimiter=" "))

optimal = 333

printme(h1_inigo, h3_inigo, h5_inigo, optimal, "fairness-inigo.data")
printme(h1_im, h3_im, h5_im, optimal, "fairness-im.data")
#printme(h1_cdg, h3_cdg, h5_cdg, optimal, "fairness-cdg.data")
printme(h1_xcp, h3_xcp, h5_xcp, optimal, "fairness-xcp.data")
