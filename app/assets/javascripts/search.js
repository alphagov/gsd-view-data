;(function (global) {
  'use strict'

  var $ = global.jQuery

  var SearchResultsContainer = (function () {
    var $searchResultContainer = $('#search-results')
    var $results = $searchResultContainer.find('.metric-group')

    var _setSearchDataAttributesOnResults = function () {
      /*
        Add the lowercased search terms to a 'data-search' attribute
        for each possible search result
       */
      $results.each(function () {
        var searchTerms = $(this).find('h2').text()
        $(this).attr('data-search', searchTerms.toLowerCase())
      })
    }

    var init = function () {
      _setSearchDataAttributesOnResults()
    }

    var filter = function (query) {
      /*
        Hide search results unless the query substring matches the title
       */
      var matches = 0

      // if query is empty, remove all hidden classes and return length of results
      if (!query) {
        $results.removeClass('hidden')
        return $results.length
      }

      $results.each(function () {
        var searchTerms = $(this).attr('data-search')
        var isMatch = searchTerms.indexOf(query) !== -1

        if (isMatch) {
          $(this).removeClass('hidden')
          matches++
        } else {
          $(this).addClass('hidden')
        }
      })

      return matches
    }

    return {
      init: init,
      filter: filter
    }
  })()

  var SearchFilter = (function () {
    var $searchFilter = $('#search-filter')
    var $searchInput = $searchFilter.find('input[type="search"]')
    var $searchButton = $searchFilter.find('input[type="button"]')

    var _search = function (fn) {
      var query = $searchInput.val().toLowerCase().trim()
      fn(query)
    }

    var _setKeyListenerOnInput = function (fn) {
      $searchInput.on('keyup', function () {
        _search(fn)
      })
    }

    var _setClickListenerOnButton = function (fn) {
      $searchButton.on('click', function (e) {
        _search(fn)
        e.preventDefault()
      })
    }

    var init = function (fn) {
      $searchFilter = $('#search-filter')
      $searchInput = $searchFilter.find('input[type="search"]')
      $searchButton = $searchFilter.find('input[type="button"]')

      $searchFilter.removeClass('hidden')
      _setKeyListenerOnInput(fn)
      _setClickListenerOnButton(fn)
    }

    return {
      init: init
    }
  })()

  SearchResultsContainer.init()
  SearchFilter.init(SearchResultsContainer.filter)
})(window)