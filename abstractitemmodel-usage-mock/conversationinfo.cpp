#include "conversationinfo.h"

#include <QDebug>

ConversationInfo::ConversationInfo(){
    conversationInfo_ = std::make_unique<std::deque<std::pair<QString, QString>>>();
}

void
ConversationInfo::insertNewConversationFront(const QString id, const QString name)
{
    conversationInfo_->push_front(std::pair<QString, QString>(id, name));
}

void
ConversationInfo::insertNewConversationBack(const QString id, const QString name)
{
    conversationInfo_->push_back(std::pair<QString, QString>(id, name));
}

void
ConversationInfo::insertNewConversation(int rowNumber, const QString id, const QString name)
{
    auto it = conversationInfo_->begin();
    it = it + rowNumber;
    conversationInfo_->insert(it, std::pair<QString, QString>(id, name));
}

bool
ConversationInfo::removeConversation(const QString id, const QString name)
{
    conversationIterator it;
    for (it = conversationInfo_->begin(); it != conversationInfo_->end(); ++it) {
        if(it->first == id && it->second == name)
            break;
    }

    if (it == conversationInfo_->end())
        return false;

    conversationInfo_->erase(it);

    return true;
}

bool
ConversationInfo::removeConversation(int index)
{
    if (index > static_cast<int>(conversationInfo_->size()) - 1)
        return false;

    conversationIterator it = conversationInfo_->begin();
    it = it + index;
    conversationInfo_->erase(it);

    return true;
}

bool
ConversationInfo::swapConveration(int indexOne, int indexTwo)
{
    if (indexOne > static_cast<int>(conversationInfo_->size()) - 1
            || indexTwo > static_cast<int>(conversationInfo_->size()) - 1)
        return false;

    auto tempInfoOne = getConversation(indexOne);
    auto tempInfoTwo = getConversation(indexTwo);

    conversationIterator it = conversationInfo_->begin();
    it = it + indexOne;
    it->first = tempInfoTwo.first;
    it->second = tempInfoTwo.second;

    it = conversationInfo_->begin();
    it = it + indexTwo;
    it->first = tempInfoOne.first;
    it->second = tempInfoOne.second;

    return true;
}

std::pair<QString, QString> ConversationInfo::getConversation(int index) const
{
    return conversationInfo_->at(index);
}

int ConversationInfo::getSize() const
{
    return static_cast<int>(conversationInfo_->size());
}

void
ConversationInfo::printAllData()
{
    using conversationIterator = std::deque<std::pair<QString, QString>>::iterator;
    conversationIterator it;
    for (it = conversationInfo_->begin(); it != conversationInfo_->end(); ++it) {
        qDebug() << it->first << " " << it->second;
    }
}
