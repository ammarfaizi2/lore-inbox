Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293202AbSBWUkK>; Sat, 23 Feb 2002 15:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSBWUkA>; Sat, 23 Feb 2002 15:40:00 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:51986 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293202AbSBWUjv>; Sat, 23 Feb 2002 15:39:51 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 23 Feb 2002 12:42:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>
Subject: ide timer trbl ...
Message-ID: <Pine.LNX.4.44.0202231238060.1449-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You guys probably already know but i'm still having problems with the ide
timer in 2.5.5 :

hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
bug: kernel timer added twice at c01c7293.
NFS: NFSv3 not supported.
nfs warning: mount version older than kernel
hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
bug: kernel timer added twice at c01c7293.


The machine seems working fine but i get these messages at the end of the
kernel boot sequence. If you need more info just let me know.




- Davide


