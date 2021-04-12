#ifndef CONVERSATIONMODEL_H
#define CONVERSATIONMODEL_H

#include <conversationinfo.h>
#include <functional>
#include <QAbstractItemModel>

class ConversationModel : public QAbstractItemModel
{
    Q_OBJECT
public:
    enum Role { ID = Qt::UserRole + 1, Username};
    Q_ENUM(Role)

    explicit ConversationModel(QObject* parent = nullptr);
    ~ConversationModel();

    /*
     * QAbstractListModel override.
     */
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    int columnCount(const QModelIndex& parent) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;

    /*
     * Override role name as access point in qml.
     */
    QHash<int, QByteArray> roleNames() const override;
    QModelIndex index(int row, int column = 0, const QModelIndex& parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex& child) const override;
    Qt::ItemFlags flags(const QModelIndex& index) const override;

    bool insertRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    bool removeRows(int row, int count, const QModelIndex &parent = QModelIndex()) override;
    bool moveRows(const QModelIndex &sourceParent, int sourceRow, int count,
                  const QModelIndex &destinationParent, int destinationChild) override;

    void createConversation();

    Q_INVOKABLE void insertConversationOnTop();
    Q_INVOKABLE void insertConversationOnBottom();
    Q_INVOKABLE void insertConversationOnMiddle();

    Q_INVOKABLE void removeConversationOnTop();
    Q_INVOKABLE void removeConversationOnBottom();
    Q_INVOKABLE void removeConversationOnMiddle();

    Q_INVOKABLE void moveBottomToTop();

private:
    int idCounter_ {0};

    ConversationInfo conversationData_;
};

#endif // CONVERSATIONMODEL_H
