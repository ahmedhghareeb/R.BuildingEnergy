test = function(bldgs, usage, single.BldgID=NULL) {
  # Pull only valid buildings
  if (is.null(single.BldgID)) {
    bldg.ID = subset(bldgs[,"BuildingID"], c(!(is.na(bldgs$PropertyName)) |
                     !(is.na(bldgs$BusinessName))) & bldgs$LeaseableArea > 0)
  } else if (is.numeric(single.BldgID)) {
    bldg.ID = single.BldgID
  }
  print(length(bldg.ID))

  # Pull only valid readings
  cln.Usage = usage[!(is.na(usage$EnergyReading)) & !(is.na(usage$EnergyCost)),]
  
  # Integration test for buildings w/o usage
  bldg.ID = bldg.ID[c(bldg.ID %in% cln.Usage$BuildingID)]
  print(length(bldg.ID))
  
  bldg.len = length(bldg.ID)
  # Loop{
  for (i in 1:bldg.len) {
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

print(unique(bldg.Usage.Gas$MeterID))    
    # Subloop
    g.len = length(bldg.Usage.Gas[,1])-1
    for (j in 1:g.len) {
      if (bldg.ID[i] %in% bldg.Usage.Gas$BuildingID) {
        # Check overlapping days in elec. & gas usage reporting ranges
        test5g =  c(as.Date(bldg.Usage.Gas[j,"EndDate"]) -
                    as.Date(bldg.Usage.Gas[j+  1,"StartDate"]))
        if (abs(test5g) >   4) {  
          print("Gas")  
          print(test5g)  
          print(as.Date(bldg.Usage.Gas[j,"EndDate"])) 
          print(as.Date(bldg.Usage.Gas[j+1,"StartDate"]))
        }
      }
    }
    
    print(unique(bldg.Usage.Elec$MeterID))
    e.len = length(bldg.Usage.Elec[,1])-1
    for (j in 1:e.len) {
      if (bldg.ID[i] %in% bldg.Usage.Elec$BuildingID) {
        test5e =  c(as.Date(bldg.Usage.Elec[j,"EndDate"]) -
                    as.Date(bldg.Usage.Elec[j+1,"StartDate"]))
        if (abs(test5e) > 4) {
          print("Elec")
          print(test5e)
          print(as.Date(bldg.Usage.Elec[j,"EndDate"]))
          print(as.Date(bldg.Usage.Elec[j+1,"StartDate"]))
        }
      }
    }
  }  
  return()
}
