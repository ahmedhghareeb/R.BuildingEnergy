test = function(bldgs, usage) {
  bldg.ID = bldgs[,"BuildingID"]
  bldg.Usage = usage[usage$BuildingID==bldg.ID[1],]
  test1 = bldg.Usage[duplicated(bldg.Usage),]
  
  print(length(bldg.Usage))
  print(length(test1))
  print(test1)
  return()
}