# btbServer
## Data server for Beyond the Book

[![Join the chat at https://gitter.im/NLeSC/btbServer](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/NLeSC/btbServer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

To start serving data, start the Flask server:

```
python btbFlaskServer.py
```

This will start the btbServer running on port 5000. The btbServer provides the following services:

 - [/wikicontrib/<word>](#Wiki contributions)
 - [/clusters/](#book clusters)
 - [/distances/](#distance matrix)

## Wiki contributions
```
http://localhost:5000/wikicontrib/<word>
```

Produce a list of Wikipedia contributions from various countries to the Wikipedia page of the given *word*. E.g:

```
http://localhost:5000/wikicontrib/London
```

Yields the contributions to the Wikipedia page for *London*. Contributions are given as an array in JSON format:
```
[
  {
    "expected": 0.383,
    "country": "US",
    "observed": 0.17480780603193377,
    "relative": -0.5112086342117579,
    "countryCode": "840"
  },
  {
    "expected": 0.132,
    "country": "UK",
    "observed": 0.5337670017740982,
    "relative": 0.7690804343009084,
    "countryCode": "826"
  },
...
  {
    "expected": 0.008,
    "country": "NL",
    "observed": 0.006859846244825547,
    "relative": -0.08169727675744143,
    "countryCode": "528"
  }
]
```
where each item represents the contributions from a country. Each item contains the following values:
 - country - 2 letter ISO code identifying the county
 - countryCode - 3 digit country code
 - expected - Expected percentage of contributions
 - observed - Observed percentage of contributions
 - relative - Calculated relative interest

## Distances
```
http://localhost:5000/distances/
```
Provides the distance between books from the Sanders corpus using LIWC categories as the features to calculate the distance. An optional *features* parameter can be included in the request to select a subset of features to use. E.g:

```
http://localhost:5000/distances/?features[]=1&features[]=2&features[]=3
```

The result is a JSON structure containing a list of books, a square matrix of book-to-book distances, and a list of features used:
```
{
  "bookNames": [
    "2008_Jardin, Willem_Monografie van de mond",
    "1994_Haasse, Hella_Transit",
    ...
    "1981_Berk, Marjan_Nooit meer slank"
  ],
  "distances": [
    [
      0.0,
      0.018213146763971403,
      ...
      0.045538534384816205
    ],
    [
      0.018213146763971403,
      0.0,
      ...
      0.027707677598918585
    ],
    ...
    [
      0.045538534384816205,
      0.027707677598918585,
      ...
      0.0
    ]
  ],
  "featureNames": [
    "Category 2, I",
    "Category 3, We",
    "Category 4, Self"
  ]
}
```

## Clusters
```
http://localhost:5000/clusters/
```

Produce a hierarchical tree of clusters from the Sanders corpus. Books are clustered based on their distances as described for the [Distances](#distances).

As with the distances, an array for *features* can be supplied to select which features are used. Additionally, a *maxdepth* parameter controls the maximum depth of the hierarchical tree to be created. E.g:

```
http://localhost:5000/clusters/?maxdepth=3&features[]=1&features[]=2
```

will use features 1 and 2, with a maximum tree depth of 3 levels. Notice that nodes which could be further sub-divided are labeled: "Cluster containing N books", while terminal nodes are labeled with the title of the book.

```

{
  "children": [
    {
      "children": [
        {
          "children": [
            {
              "name": "2004_Noort, Saskia_De eetclub"
            },
            {
              "name": "Cluster containing 3 books"
            }
          ],
          "name": ""
        },
        {
          "children": [
            {
              "name": "Cluster containing 28 books"
            },
            {
              "name": "Cluster containing 13 books"
            }
          ],
          "name": ""
        }
      ],
      "name": ""
    },
    {
      "children": [
        {
          "children": [
            {
              "name": "Cluster containing 150 books"
            },
            {
              "name": "Cluster containing 167 books"
            }
          ],
          "name": ""
        },
        {
          "children": [
            {
              "name": "Cluster containing 89 books"
            },
            {
              "name": "Cluster containing 101 books"
            }
          ],
          "name": ""
        }
      ],
      "name": ""
    }
  ],
  "name": ""
}
```
