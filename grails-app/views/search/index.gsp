<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <title>Search | HS - JMS Master/Slave Configuration</title>
      <style type="text/css">
      * {
        font-family: Arial, sans-serif;
        padding: 0;
        margin: 0;
      }

      body {
        font-size: 0.9em;
        padding: .5em;
          /*background-color:#b0c4de;*/
      }

      #header form input {
        padding: .1em;
      }

      #header .hint {
        color: gray;
      }

      #header h1 a {
        text-decoration: none;
        font-family: Georgia, serif;
          color: dimgray;
      }

      #header h1 {
          letter-spacing: -0.1em;
          float: left;
      }

      #header h1 span {
          font-family: Georgia, serif;
          color: #424242;
      }

      #header form {
          margin-left: 22em;
          padding-top: .1em;
      }

      .title {
        margin: 1em 0;
        padding: .3em .5em;
        text-align: left;
        background-color: seashell;
        border-top: 1px solid lightblue;
      }

      .result {
        margin-bottom: 1em;
      }

      .result .displayLink {
        color: green;
      }

      .result .name {
        font-size: larger;
      }

      .paging a.step {
        padding: 0 .3em;
      }

      .paging span.currentStep {
          font-weight: bold;
      }

      ul {
        margin: 1em 2em;
      }

      li, p {
        margin-bottom: 1em;
      }
    </style>
  </head>
  <body>


  <div id="">
  <h3>Search (jms master/slave configuration)</h3>
  <g:form url='[controller: "search", action: "index"]' id="searchableForm" name="searchableForm" method="get">
        %{--<g:textField name="q" value="${params.q}" size="75"/> <input type="submit" value="Search" />--}%
        <g:textArea name="q" value="${params.q}" rows="10" cols="75"/> <input type="submit" value="Search" />
        <g:hiddenField name="max" value="10"/>
    </g:form>
    </div>

  <div id="main">
  <g:set var="haveResults" value="${searchResult?.size() > 0}" />
  <g:set var="haveQuery" value="${params.q?.trim()}" />

      <div class="title">
  <g:if test="${haveResults && haveQuery}">
  Showing results for <strong>${params.q}</strong>
      <p> Match count: <strong>${total}</strong></p>
      <p> Search Time: <strong>${searchTime} ms</strong></p>
  </g:if>
  <g:else>
      &nbsp;
  </g:else>
      </div>

  <g:if test="${haveQuery && !haveResults}">
      <p>Nothing matched your query - <strong>${params.q}</strong></p>
  </g:if>

  <g:if test="${haveResults}">

      <div class="results">
          <table>
              <th>Title</th>
              <th>Runtime</th>
              <th>Genre</th>
          <g:each var="result" in="${searchResult}" status="index">
              <tr>
                  <td>${result.title}</td>
                  <td>${result.runtime}</td>
                  <td>${result.genre}</td>
              </tr>
          </g:each>
          </table>
      </div>

      <div>
          <div class="paging">
              <g:if test="${haveResults}">
                  Page:
                  <g:set var="totalPages" value="${Math.ceil(total/max)}"/>
                  <g:if test="${totalPages == 1}">
                      <span class="currentStep">1</span>
                  </g:if>
                  <g:else>
                      <g:paginate total="${total}" controller="search" action="index" params="[q: params.q]" prev="&lt; previous" next="next &gt;"/>
                  </g:else>
              </g:if>
          </div>
      </div>
  </g:if>

  <g:if test="${parseException}">
      <p>Your query - <strong>${params.q}</strong> - is not valid.</p>
  </g:if>
  </div>
  </body>
</html>