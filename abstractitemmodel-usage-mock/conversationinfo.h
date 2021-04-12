#ifndef CONVERSATIONINFO_H
#define CONVERSATIONINFO_H

#include <QString>
#include <deque>
#include <memory>

class ConversationInfo
{
public:
    explicit ConversationInfo();
    ~ConversationInfo() = default;

    using conversationIterator = std::deque<std::pair<QString, QString>>::iterator;

    void insertNewConversationFront(const QString id, const QString name);
    void insertNewConversationBack(const QString id, const QString name);
    void insertNewConversation(int rowNumber, const QString id, const QString name);

    bool removeConversation(const QString id, const QString name);
    bool removeConversation(int index);

    bool swapConveration(int indexOne, int indexTwo);

    std::pair<QString, QString> getConversation(int index) const;
    int getSize() const;

    void printAllData();

private:
    std::unique_ptr<std::deque<std::pair<QString, QString>>> conversationInfo_;
};

#endif // CONVERSATIONINFO_H
