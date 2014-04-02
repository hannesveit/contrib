##################################################
###       LIBKDTREE 													 ###
##################################################

MACRO( OPENMS_CONTRIB_BUILD_LIBKDTREE )
  OPENMS_LOGHEADER_LIBRARY("LIBKDTREE")
  #extract: (takes very long.. so skip if possible)
  if(MSVC)
    set(ZIP_ARGS "x -y -osrc")
  else()
    set(ZIP_ARGS "xzf")
  endif()
  OPENMS_SMARTEXTRACT(ZIP_ARGS ARCHIVE_LIBKDTREE "LIBKDTREE" "README")

## copy includes
configure_file(${LIBKDTREE_DIR}/libkdtreeplusplus.h ${CONTRIB_BIN_INCLUDE_DIR} COPYONLY)

ENDMACRO( OPENMS_CONTRIB_BUILD_LIBKDTREE )
