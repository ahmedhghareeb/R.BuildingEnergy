test = function(bldgs, usage) {
  bldg.ID = subset(bldgs[,"BuildingID"], c(!(is.na(bldgs$PropertyName)) | !(is.na(bldgs$BusinessName))) & bldgs$LeaseableArea > 0)
  cln.Usage = usage[!(is.na(usage$EnergyReading)) & !(is.na(usage$EnergyCost)),]
  
  #loop{
  bldg.Usage = cln.Usage[cln.Usage$BuildingID==bldg.ID[1],]
  test3 = bldg.Usage[duplicated(bldg.Usage),]
  spans = as.Date(bldg.Usage[,"EndDate"]) - as.Date(bldg.Usage[,"StartDate"]) 
  #}
  
  print(typeof(spans))
  print(as.numeric(spans))

  return()
}