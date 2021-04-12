#include "animalmodel.h"

#include <QDebug>

Animal::Animal(const QString &type, const QString &size)
    : m_type(type), m_size(size)
{
}

QString
Animal::type() const
{
    return m_type;
}

QString
Animal::size() const
{
    return m_size;
}







AnimalModel::AnimalModel(QObject *parent)
    : QAbstractListModel(parent),
      m_sortFilterModel(new SelectableProxyModel(this))
{
    // filter by type
    m_sortFilterModel->setPredicate([this](const QModelIndex& index, const QRegExp& regex) {
        return regex.indexIn(index.data(AnimalRoles::TypeRole).toString()) != -1;
    });
}

void
AnimalModel::addAnimal(const Animal &animal)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_animals << animal;
    endInsertRows();
}

int
AnimalModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_animals.count();
}

QVariant
AnimalModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_animals.count())
        return QVariant();

    const Animal &animal = m_animals[index.row()];
    if (role == TypeRole)
        return animal.type();
    else if (role == SizeRole)
        return animal.size();
    return QVariant();
}

QHash<int, QByteArray>
AnimalModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "type";
    roles[SizeRole] = "size";
    return roles;
}

QModelIndex
AnimalModel::index(int row, int column, const QModelIndex &parent) const
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

void
AnimalModel::slotSearchBarTextChanged(const QString& text)
{
    m_sortFilterModel->setFilterRegExp(QRegExp(text, Qt::CaseInsensitive, QRegExp::FixedString));
}
