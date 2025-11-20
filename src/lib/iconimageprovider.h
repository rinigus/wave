// SPDX-FileCopyrightText: 2020 Jonah Brüchert <jbb@kaidan.im>
// SPDX-FileCopyrightText: 2020 Rinigus <rinigus.git@gmail.com>
//
// SPDX-License-Identifier: GPL-2.0-or-later

#ifndef ICONIMAGEPROVIDER_H
#define ICONIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QSet>


class QQmlApplicationEngine;

class IconImageProvider : public QQuickImageProvider
{
public:
    IconImageProvider(QQmlApplicationEngine *engine);

    virtual QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

    // store image into the database if it is missing. Return new
    // image:// uri that should be used to fetch the icon
    static QString storeImage(const QString &iconSource);

    static QString providerId();

private:
    static void fetchAndStoreIcon(const QString &url, const QString &iconSource);

    static QQmlApplicationEngine *s_engine;
    static QSet<QString> s_activeFetches;
};

#endif // ICONIMAGEPROVIDER_H
