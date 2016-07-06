#ifndef BOOK_H
#define BOOK_H

#include <iostream>
#include <map>
#include <string>
#include <vector>
#include <sstream>

class Book {
public:
    /** Constructor & Destructor */
    Book();
    virtual ~Book();

    /** Getters and Setters */
    unsigned int getWikiId() { return wikiId; }
    void setWikiId(unsigned int val) { wikiId = val; }
    std::string getFreebaseId() { return freebaseId; }
    void setFreebaseId(std::string val) { freebaseId = val; }
    std::string getTitle() { return title; }
    void setTitle(std::string val) { title = val; }
    std::string getAuthor() { return author; }
    void setAuthor(std::string val) { author = val; }
    std::string getPublicationDate() { return publicationDate; }
    void setPublicationDate(std::string val) { publicationDate = val; }
    std::vector<std::string> getGenres() { return genres; }
    void setGenres(std::vector<std::string> val) { genres = val; }
    std::string getSummary() { return summary; }
    void setSummary(std::string val) { summary = val; }

    /** Other methods */
    void createVectorSpace();
    void printInfo();
    void printVectorSpace();

protected:

private:

    unsigned int wikiId; //!< Member variable "wikiId"
    std::string freebaseId; //!< Member variable "freebaseId"
    std::string title; //!< Member variable "title"
    std::string author; //!< Member variable "author"
    std::string publicationDate; //!< Member variable "publicationDate"
    std::vector<std::string> genres; //!< Member variable "genres"
    std::string summary; //!< Member variable "summary"
    std::map<std::string, int> vectorSpace;
};

#endif // BOOK_H
