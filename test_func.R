test = function(bldgs, usage) {
  bldg.ID = subset(bldgs[,"BuildingID"], c(!(is.na(bldgs$PropertyName)) | !(is.na(bldgs$BusinessName))) & bldgs$LeaseableArea > 0)
  print(length(bldg.ID))
  
  bldg.Usage = usage[usage$BuildingID==bldg.ID[1],]
  test3 = bldg.Usage[duplicated(bldg.Usage),]
  # test4 = 
  
  # print(length(bldg.Usage))
  # print(length(test3))
  # print(test3)

  return()
}