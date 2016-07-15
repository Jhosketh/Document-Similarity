#include "Book.h"

Book::Book() {
    //ctor
}

Book::~Book() {
    //dtor
}

void Book::createVectorSpace() {
    std::string str = summary;
    cleanUpString(str);

    std::stringstream ss(str);
    std::string term;

    while(getline(ss, term, ' ')) {
        if ((int)term[0] != 0) {
            std::map<std::string, int>::iterator it;
            it = vectorSpace.find(term);
            if (it != vectorSpace.end()) { // has ever occurred
                it->second = it->second + 1;
            } else {
                vectorSpace.insert(std::pair<std::string, int>(term, 1));
            }
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
    int i=0;
    for (it=vectorSpace.begin(); it!=vectorSpace.end(); ++it) {
        std::cout << it->first << ": " << it->second << std::endl;
        i++;
    }
    std::cout << "Total: " << i << std::endl;
}

void Book::printToExternal(std::ofstream &os) {
    os << wikiId << std::endl;
    os << freebaseId << std::endl;
    os << title << std::endl;
    os << author << std::endl;
    os << publicationDate << std::endl;
    os << genres << std::endl;
    std::map<std::string, int>::iterator it;
    for (it=vectorSpace.begin(); it!=vectorSpace.end(); ++it) {
        os << it->first << " " << it->second << std::endl;
    }
}

void Book::printCorpusToExternal(std::ofstream &os) {
    os << summary << std::endl;
}

bool Book::invalidChar(char c) {
    return !((c>=48 && c <57) || (c>=65 && c<=90) || (c>=97 && c<=122) || c==32);
}

bool Book::bothAreSpaces(char lhs, char rhs) {
    return (lhs == rhs) && (lhs == ' ');
}


void Book::replaceAll(std::string& str, const std::string& from, const std::string& to) {
    if(from.empty())
        return;
    size_t start_pos = 0;
    while((start_pos = str.find(from, start_pos)) != std::string::npos) {
        str.replace(start_pos, from.length(), to);
        start_pos += to.length(); // In case 'to' contains 'from', like replacing 'x' with 'yx'
    }
}

void Book::cleanUpString(std::string & str) {
    std::transform(str.begin(), str.end(), str.begin(), ::tolower);
    replaceAll(str, "'s", "");
    // std::string::iterator new_end = std::unique(str.begin(), str.end(), bothAreSpaces);
    // str.erase(new_end, str.end());
    str.erase(remove_if(str.begin(),str.end(), invalidChar), str.end());
}
