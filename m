Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbQKVKT3>; Wed, 22 Nov 2000 05:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131490AbQKVKTT>; Wed, 22 Nov 2000 05:19:19 -0500
Received: from 213-123-77-95.btconnect.com ([213.123.77.95]:38148 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131474AbQKVKTM>;
	Wed, 22 Nov 2000 05:19:12 -0500
Date: Wed, 22 Nov 2000 09:51:02 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Joe Harrington <jharring@micron.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: filesystems
In-Reply-To: <Pine.LNX.4.21.0011220923100.1197-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011220948110.1197-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Tigran Aivazian wrote:
> you do not mount a VFS filesystem. VFS is not a filesystem. VFS is a
> Virtual Filesystem Switch, i.e. a set of concepts, philosophy, data
> structures and functions which together make writing new filesystems easy.
> The name is derived from the SVR4 data structure vfssw (sic?) whence all
> the good concepts of VFS came (yea, yea, I know, AV (and history books)
> will tell me that Sun had a vnode/vfs layer and that even FreeBSD has a
> sort of VFS/vnode layer but we all know that the really good form of VFS
> came from SVR4, like it or not, the others, except Linux of course, are
> impostors)

perhaps I invented a new English word "achronal impostor", i.e. impostor
even if he was there before others ;)

And, to emphasize my respect to Al Viro, I would like to explain that I
sometimes spell "my personal humble opinion" as "we all know", just read
between the lines and you will be Ok.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
