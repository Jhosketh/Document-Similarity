#include "Book.h"

Book::Book() {
    //ctor
}

Book::~Book() {
    //dtor
}

void Book::createVectorSpace() {
    std::stringstream ss(summary);
    std::string term;

    while(getline(ss, term, ' ')) {
        std::map<std::string, int>::iterator it;
        it = vectorSpace.find(term);
        if (it != vectorSpace.end()) { // has ever occurred
            it->second = it->second + 1;
        } else {
            vectorSpace.insert(std::pair<std::string, int>(term, 1));
        }
    }
}

void Book::printInfo() {
    std::cout << "Wiki ID       : " << wikiId << std::endl;
    std::cout << "Freebase ID   : " << freebaseId << std::endl;
    std::cout << "Title         : " << title << std::endl;
    std::cout << "Author        : " << author << std::endl;
    std::cout << "Pub. date     : " << publicationDate << std::endl;
    std::cout << "Genres        : " << std::endl;
    std::cout << "Summary       : " << std::endl << summary << std::endl;
}

void Book::printVectorSpace() {
    std::map<std::string, int>::iterator it;
    for (it=vectorSpace.begin(); it!=vectorSpace.end(); ++it) {
        std::cout << it->first << ": " << it->second << std::endl;
    }
}
