test = function(bldgs, usage) {
  # Pull only valid buildings
  bldg.ID = subset(bldgs[,"BuildingID"], c(!(is.na(bldgs$PropertyName)) |
                   !(is.na(bldgs$BusinessName))) & bldgs$LeaseableArea > 0)
  print(length(bldg.ID))
  # Pull only valid readings
  cln.Usage = usage[!(is.na(usage$EnergyReading)) & !(is.na(usage$EnergyCost)),]
  
  # Integration test for buildings w/o usage
  bldg.ID = bldg.ID[c(bldg.ID %in% cln.Usage$BuildingID)]
  print(length(bldg.ID))
  
  # Loop{
  i = 5
  # Pull valid usage records associated with valid buildings
  bldg.Usage = data.frame(cln.Usage[cln.Usage$BuildingID==bldg.ID[i],])
  print(bldg.ID[i])
  
  bldg.Usage.Elec = bldg.Usage[bldg.Usage$MeterUnits=="kWh",]
  bldg.Usage.Elec = bldg.Usage.Elec[order(as.Date(bldg.Usage.Elec$StartDate)),]
  
  bldg.Usage.Gas = bldg.Usage[bldg.Usage$MeterUnits=="Therm",]
  bldg.Usage.Gas = bldg.Usage.Gas[order(as.Date(bldg.Usage.Gas$StartDate)),]
  
  # Test for dupicate entries: returns duplicates
  # (Test 1 & 2 are imbeded in the import section above)
  test3 = bldg.Usage[duplicated(bldg.Usage),]
  print("Test 3")
  print(test3)
  
  # Test for length of each record: returns valid records
  test4 = subset(c(as.Date(bldg.Usage[,"EndDate"]) - 
                   as.Date(bldg.Usage[,"StartDate"])),
                 c(as.Date(bldg.Usage[,"EndDate"]) -
                   as.Date(bldg.Usage[,"StartDate"]) < 14) &
                 c(as.Date(bldg.Usage[,"EndDate"]) -
                   as.Date(bldg.Usage[,"StartDate"]) > 60))
  print("Test 4")
  print(test4)
  
  # Subloop
  g.len = length(bldg.Usage.Gas[,1])-1
  for (j in 1:g.len) {
    # Check overlapping days in elec. & gas usage reporting ranges
    test5g =  c(as.Date(bldg.Usage.Gas[j,"EndDate"]) -
                as.Date(bldg.Usage.Gas[j+  1,"StartDate"]))  
    if (abs(test5g) >   4) {  
      print("Gas")  
      print(bldg.Usage.Gas[j,"MeterID"])  
      print(as.Date(bldg.Usage.Gas[j,"EndDate"])) 
      print(as.Date(bldg.Usage.Gas[j+1,"StartDate"]))
    }

  e.len = length(bldg.Usage.Elec[,1])-1
  for (j in 1:e.len)
    test5e =  c(as.Date(bldg.Usage.Elec[j,"EndDate"]) -
                as.Date(bldg.Usage.Elec[j+1,"StartDate"]))
    if (abs(test5e) > 4) {
      print("Elec")
      print(as.Date(bldg.Usage.Elec[j,"MeterID"]))
      print(as.Date(bldg.Usage.Elec[j,"EndDate"]))
      print(as.Date(bldg.Usage.Elec[j+1,"StartDate"]))
    }
  }
  #}
  
  return()
}
