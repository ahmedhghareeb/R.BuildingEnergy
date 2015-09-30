test = function(bldgs, usage) {
  bldg.ID = subset(bldgs[,"BuildingID"], !(bldgs$PropertyName=="") | bldgs$LeaseableArea > 0)
  print(length(bldg.ID))
  
  bldg.Usage = usage[usage$BuildingID==bldg.ID[1],]
  test3 = bldg.Usage[duplicated(bldg.Usage),]
  
  # print(length(bldg.Usage))
  # print(length(test3))
  # print(test3)

  return()
}