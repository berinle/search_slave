package com.jrock.hsdemo

constraints = {
    title blank:false
    runtime blank:false
    genre(inList:['Action', 'Comedy', 'Drama', 'Thriller', 'Horror'])
}
