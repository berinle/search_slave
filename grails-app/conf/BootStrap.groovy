import com.jrock.hsdemo.Movie

class BootStrap {

    def init = { servletContext ->

        //create some sample movies
        if(Movie.list() == 0){
            println " seeding the database "
            new Movie(title:'The Dutchess', runtime:120, genre:"Drama").save()
            new Movie(title:'Are we there yet?', runtime:90, genre:"Comedy").save()
            new Movie(title:'Air Force One', runtime:120, genre:"Action").save()
        }
    }
    def destroy = {
    }
}
