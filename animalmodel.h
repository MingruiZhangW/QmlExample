#pragma once

// Qt include
#include <QAbstractItemModel>
#include <QSortFilterProxyModel>

class SelectableProxyModel : public QSortFilterProxyModel
{
public:
    using FilterPredicate = std::function<bool(const QModelIndex&, const QRegExp&)>;

    explicit SelectableProxyModel(QAbstractListModel* parent) : QSortFilterProxyModel(parent) {
        setSourceModel(parent);
    }

    void setPredicate(FilterPredicate filterPredicate) {
        filterPredicate_ = filterPredicate;
    }

    virtual bool filterAcceptsRow(int source_row, const QModelIndex& source_parent) const {
        // Accept all contacts in conversation list filtered with account type, except those in a call
        auto index = sourceModel()->index(source_row, 0, source_parent);
        if (filterPredicate_) {
            return filterPredicate_(index, filterRegExp());
        }
        return true;
    }

private:
    std::function<bool(const QModelIndex&, const QRegExp&)> filterPredicate_;

};

class Animal
{
public:
    Animal(const QString &type, const QString &size);

    QString type() const;
    QString size() const;

private:
    QString m_type;
    QString m_size;
};

class AnimalModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum AnimalRoles {
        TypeRole = Qt::UserRole + 1,
        SizeRole
    };

    AnimalModel(QObject *parent = 0);

    void addAnimal(const Animal &animal);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    QModelIndex index(int row, int column, const QModelIndex &parent = QModelIndex()) const;

    SelectableProxyModel* getFilter() { return m_sortFilterModel; }

public slots:
    void slotSearchBarTextChanged(const QString& text);

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Animal> m_animals;
    SelectableProxyModel* m_sortFilterModel;
};
