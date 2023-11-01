{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": [],
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "ir",
      "display_name": "R"
    },
    "language_info": {
      "name": "R"
    }
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/jessctanugi/quanteda/blob/main/F22Quanteda_R.R\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "# Text Analysis in R with Quanteda\n",
        "\n",
        "This is the reference notebook for the workshop that has code that differs slightly from what we'll do in the live workshop, because of the limits of the online environment.\n",
        "\n",
        "First up, we need to install the packages we'll need to get started. We'll install more later in subsections of the workshop. On the online environment, the installation takes quite a while (~5 min)."
      ],
      "metadata": {
        "id": "L8cYWZJenANy"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "install.packages(\"quanteda\")\n",
        "install.packages(\"tidyverse\")\n",
        "#install.packages(\"readtext\") #Doesn't work on colab, but does work locally. For colab we'll have to use read_csv()."
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "A0h_HvmXis4N",
        "outputId": "49b27411-61cd-4a65-d364-f2970ecd53e3"
      },
      "execution_count": 2,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n",
            "also installing the dependencies ‘ISOcodes’, ‘fastmatch’, ‘Rcpp’, ‘RcppParallel’, ‘SnowballC’, ‘stopwords’, ‘RcppArmadillo’\n",
            "\n",
            "\n",
            "Installing package into ‘/usr/local/lib/R/site-library’\n",
            "(as ‘lib’ is unspecified)\n",
            "\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "Next we'll load the libraries we'll need for this first session."
      ],
      "metadata": {
        "id": "1tB9Xbv2nUR9"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "library(quanteda)\n",
        "library(tidyverse)\n",
        "#library(readtext)"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "GypJ8MfDmeXX",
        "outputId": "23dbb571-ce20-4acd-c026-7d98a04771a1"
      },
      "execution_count": 3,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stderr",
          "text": [
            "Package version: 3.3.1\n",
            "Unicode version: 14.0\n",
            "ICU version: 70.1\n",
            "\n",
            "Parallel computing: 2 of 2 threads used.\n",
            "\n",
            "See https://quanteda.io for tutorials and examples.\n",
            "\n",
            "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
            "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.3     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
            "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.0\n",
            "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.4     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
            "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.3     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
            "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.2     \n",
            "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
            "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
            "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
            "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "## Import Data\n",
        "\n",
        "Now we'll read in the data for the workshop. Locally, we'll be using ``readtext()``, which is built for flexibly reading in text in a number of different ways."
      ],
      "metadata": {
        "id": "cXXmBArixUub"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "#For colab\n",
        "#read_csv()\n",
        "stevenson <- read_csv(\"https://raw.githubusercontent.com/jessctanugi/quanteda/main/data/stevenson_letters_original.csv\")\n",
        "#What do we have?\n",
        "head(stevenson)"
      ],
      "metadata": {
        "id": "V_qgtcgumoZz"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "#For Workshop\n",
        "#readtext() is built to take text from corpora more naturally.\n",
        "stevenson <- readtext(\"https://raw.githubusercontent.com/jessctanugi/quanteda/main/data/stevenson_letters_original.csv\", text_field = \"letter_text\", docid_field = \"location\")"
      ],
      "metadata": {
        "id": "vPRxcamo9lrW"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "## Clean data\n",
        "\n",
        "We have our data in dataframe format. However, it's quite messy with html tags and not ready for further analysis until we fix it.\n",
        "\n",
        "Using a simple regular expression designed to find any content between an open bracket (<) and the very next closing bracket (>), we can get rid of the html tags easily."
      ],
      "metadata": {
        "id": "5maWxBE-2nlo"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "#For colab\n",
        "#Get rid of html tags\n",
        "stevenson$letter_text <- gsub(\"<.*?>\", \"\", stevenson$letter_text) #NOTE: can't use the pipe because the data IS NOT the first argument.\n",
        "head(stevenson, 2)\n",
        "#One more thing is going to mess us up: they all start with Letter: . Let's fix it.\n",
        "stevenson$letter_text <- gsub(\"Letter: \", \"\", stevenson$letter_text)\n",
        "head(stevenson, 2)"
      ],
      "metadata": {
        "id": "F2yiBst03QEW"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "#For workshop\n",
        "stevenson$text <- gsub(\"<.*?>\", \"\", stevenson$text) #NOTE: can't use the pipe because the data IS NOT the first argument.\n",
        "head(stevenson, 2)\n",
        "#One more thing is going to mess us up: they all start with Letter: . Let's fix it.\n",
        "stevenson$text <- gsub(\"Letter: \", \"\", stevenson$text)\n",
        "head(stevenson, 2)"
      ],
      "metadata": {
        "id": "sPfTycYV9gEx"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "## Make a corpus\n",
        "\n",
        "Let's change our dataframe into a corpus."
      ],
      "metadata": {
        "id": "2Hj6F4Dy3_aP"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "#For colab:\n",
        "corp_stevenson <- stevenson %>%  corpus(text_field = \"letter_text\")"
      ],
      "metadata": {
        "id": "JyloGreZ4KNX"
      },
      "execution_count": null,
      "outputs": []
    }
  ]
}