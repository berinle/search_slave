package com.jrock.hsdemo

import org.apache.lucene.search.SortField
import org.apache.lucene.search.Sort
import org.apache.lucene.search.Query
import org.apache.lucene.util.Version
import org.apache.lucene.analysis.standard.StandardAnalyzer
import org.apache.lucene.queryParser.QueryParser
import org.hibernate.search.Search

class SearchController {

    def index = {
        log.debug "search() called, performing search"

        if (!params.q?.trim()) {
            return [:]
        }
        try {
          log.info  "query: ${params.q}"

            if(!params.max) params.max = 10
            if(!params.offset) params.offset = 0

            long start = System.currentTimeMillis()
            Movie.withSession{ session ->
                //set hold of full text session
                def fts = Search.getFullTextSession(session)

                def parser = new QueryParser(Version.LUCENE_30, "title", new StandardAnalyzer(Version.LUCENE_30))


                //attempt to parse lucene query
                Query luceneQuery = parser.parse(params.q)

                //perform the search
                def query = fts.createFullTextQuery(luceneQuery, Movie.class)
                query.setSort(new Sort(new SortField("title", SortField.STRING, false)))
                log.debug "about to execute query"
                int max_int = Integer.valueOf(params.max)
                int first_result = Integer.valueOf(params.offset)

                def totalCount = query.getResultSize()
                def searchResult = query.setMaxResults(max_int).setFirstResult(first_result).list()
                log.debug "finished executing query..."

                long end = System.currentTimeMillis()

                long searchTime = end - start

                log.debug " Found " + totalCount + " for query ' " + params.q + " '"

                //return result to view
                [searchResult:searchResult, total:totalCount, max:max_int, searchTime: searchTime]

            }

        } catch (ex) {
            println ex.printStackTrace()
            return [parseException: true]
        }
    }
}
