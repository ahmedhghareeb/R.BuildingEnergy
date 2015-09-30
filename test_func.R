test = function(bldgs, usage) {
  bldg.ID = subset(bldgs[,"BuildingID"], c(!(is.na(bldgs$PropertyName)) | !(is.na(bldgs$BusinessName))) & bldgs$LeaseableArea > 0)
  # print(length(bldg.ID))
  
  cln.Usage = usage[!(is.na(usage$EnergyReading)) & !(is.na(usage$EnergyCost)),]
  bldg.Usage = cln.Usage[cln.Usage$BuildingID==bldg.ID[1],]
  test3 = bldg.Usage[duplicated(bldg.Usage),]
  test4 = as.Date(bldg.Usage[1,"StartDate"]) - as.Date(bldg.Usage[2,"StartDate"])
  
  print(typeof(test4))
  print(as.numeric(test4))

  return()
}