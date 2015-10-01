test = function(bldgs, usage) {
  bldg.ID = subset(bldgs[,"BuildingID"], c(!(is.na(bldgs$PropertyName)) | !(is.na(bldgs$BusinessName))) & bldgs$LeaseableArea > 0)
  cln.Usage = usage[!(is.na(usage$EnergyReading)) & !(is.na(usage$EnergyCost)),]
  
  #loop{
  bldg.Usage = cln.Usage[cln.Usage$BuildingID==bldg.ID[1],]
  test3 = bldg.Usage[duplicated(bldg.Usage),]
  test4 = subset(c(as.Date(bldg.Usage[,"EndDate"]) - as.Date(bldg.Usage[,"StartDate"])), c(as.Date(bldg.Usage[,"EndDate"]) - as.Date(bldg.Usage[,"StartDate"]) > 14) &
                 c(as.Date(bldg.Usage[,"EndDate"]) - as.Date(bldg.Usage[,"StartDate"]) < 60))
  #}
  
  print(length(test4))
  print(test4)

  return()
}
