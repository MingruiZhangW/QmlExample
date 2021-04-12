#include "conversationmodel.h"

#include <QRandomGenerator>
#include <QDebug>

QString GetRandomString()
{
   const QString possibleCharacters("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789");
   const int randomStringLength = 12; // assuming you want random strings of 12 characters

   QString randomString;
   for(int i=0; i<randomStringLength; ++i)
   {
       int index =  QRandomGenerator::global()->generate() % possibleCharacters.length();
       QChar nextChar = possibleCharacters.at(index);
       randomString.append(nextChar);
   }
   return randomString;
}

ConversationModel::ConversationModel(QObject* parent)
    : QAbstractItemModel(parent)
{
    createConversation();
}

ConversationModel::~ConversationModel() {}

void
ConversationModel::createConversation()
{
    conversationData_.insertNewConversationBack(QString::number(++ idCounter_), "Alice");
    conversationData_.insertNewConversationBack(QString::number(++ idCounter_), "Bob");
    conversationData_.insertNewConversationBack(QString::number(++ idCounter_), "Cici");
    conversationData_.insertNewConversationBack(QString::number(++ idCounter_), "Dada");
    conversationData_.insertNewConversationBack(QString::number(++ idCounter_), "Erre");
}

int
ConversationModel::rowCount(const QModelIndex& parent) const
{
    if (!parent.isValid()) {
        /*
         * Count.
         */
        return conversationData_.getSize();
    }
    /*
     * A valid QModelIndex returns 0 as no entry has sub-elements.
     */
    return 0;
}

int
ConversationModel::columnCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    /*
     * Only need one column.
     */
    return 1;
}

QVariant
ConversationModel::data(const QModelIndex& index, int role) const
{
    auto data = conversationData_.getConversation(index.row());
    switch (role) {
    case Role::Username:
        return QVariant(data.first);
    case Role::ID:
        return QVariant(data.second);
    }
    return QVariant();
}

QHash<int, QByteArray>
ConversationModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Username] = "Username";
    roles[ID] = "ID";
    return roles;
}

QModelIndex
ConversationModel::index(int row, int column, const QModelIndex& parent) const
{
    Q_UNUSED(parent);
    if (column != 0) {
        return QModelIndex();
    }

    if (row >= 0 && row < rowCount()) {
        return createIndex(row, column);
    }
    return QModelIndex();
}

QModelIndex
ConversationModel::parent(const QModelIndex& child) const
{
    Q_UNUSED(child);
    return QModelIndex();
}

Qt::ItemFlags
ConversationModel::flags(const QModelIndex& index) const
{
    auto flags = QAbstractItemModel::flags(index) | Qt::ItemNeverHasChildren | Qt::ItemIsSelectable;
    if (!index.isValid()) {
        return QAbstractItemModel::flags(index);
    }
    return flags;
}

bool
ConversationModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    conversationData_.insertNewConversation(row, QString::number(++ idCounter_), GetRandomString());
    endInsertRows();

    return true;
}

bool
ConversationModel::removeRows(int row, int count, const QModelIndex &parent)
{
    bool result = false;

    beginRemoveRows(parent, row, row + count - 1);
    result = conversationData_.removeConversation(row);
    endRemoveRows();

    return result;
}

bool
ConversationModel::moveRows(const QModelIndex &sourceParent, int sourceRow, int count,
                             const QModelIndex &destinationParent, int destinationChild)
{
    bool result = false;

    beginMoveRows(sourceParent, sourceRow, sourceRow + count - 1, sourceParent, destinationChild);
    result = conversationData_.swapConveration(sourceRow, destinationChild);
    endMoveRows();

    return result;
}

void
ConversationModel::insertConversationOnTop()
{
    insertRows(0, 1);
}

void
ConversationModel::insertConversationOnBottom()
{
    insertRows(rowCount(), 1);
}

void
ConversationModel::insertConversationOnMiddle()
{
    insertRows(rowCount() / 2, 1);
}

void
ConversationModel::removeConversationOnTop()
{
    removeRows(0, 1);
}

void
ConversationModel::removeConversationOnBottom()
{
    removeRows(rowCount() - 1, 1);
}

void
ConversationModel::removeConversationOnMiddle()
{
    removeRows((rowCount() - 1) / 2, 1);
}

void
ConversationModel::moveBottomToTop()
{
    moveRows(QModelIndex(), rowCount() - 1, 1, QModelIndex(), 0);
}
