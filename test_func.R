test = function(bldgs, usage) {
  # Pull only valid buildings
  bldg.ID = subset(bldgs[,"BuildingID"], c(!(is.na(bldgs$PropertyName)) | !(is.na(bldgs$BusinessName))) & bldgs$LeaseableArea > 0)
  # Pull only valid readings
  cln.Usage = usage[!(is.na(usage$EnergyReading)) & !(is.na(usage$EnergyCost)),]
  
  # Loop{
  i = 23
  # Pull valid usage records associated with valid buildings
  bldg.Usage = data.frame(cln.Usage[cln.Usage$BuildingID==bldg.ID[i],])
  bldg.Usage = bldg.Usage[order(as.Date(bldg.Usage$StartDate)),]
  # Test for dupicate entries: returns duplicates (Test 1 & 2 are imbeded in the import section above)
  test3 = bldg.Usage[duplicated(bldg.Usage),]
  # Test for length of each record: returns valid records
  test4 = subset(c(as.Date(bldg.Usage[,"EndDate"]) - as.Date(bldg.Usage[,"StartDate"])),
                 c(as.Date(bldg.Usage[,"EndDate"]) - as.Date(bldg.Usage[,"StartDate"]) > 14) &
                 c(as.Date(bldg.Usage[,"EndDate"]) - as.Date(bldg.Usage[,"StartDate"]) < 60))
   # Subloop{
  j = 1
  test5 =  c(as.Date(bldg.Usage[j,"EndDate"]) - as.Date(bldg.Usage[j+1,"EndDate"]))
   #}
  #}

  print(bldg.ID[i])
  print(typeof(bldg.Usage))
  print(bldg.Usage)
  print(as.Date(bldg.Usage[j,"EndDate"]))
  print(as.Date(bldg.Usage[j+1,"EndDate"]))
  print(test5)
  # print(bldg.Usage)

  return()
}
