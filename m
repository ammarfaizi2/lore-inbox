Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129386AbQJ0WjS>; Fri, 27 Oct 2000 18:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129229AbQJ0WjI>; Fri, 27 Oct 2000 18:39:08 -0400
Received: from boss.staszic.waw.pl ([195.205.163.66]:51973 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129786AbQJ0WjB>; Fri, 27 Oct 2000 18:39:01 -0400
Date: Sat, 28 Oct 2000 00:41:48 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: linux-kernel@vger.kernel.org
cc: andre@linux-ide.org
Subject: [ANNOUNCE] ide-patch for 2.2.18(pre)
Message-ID: <Pine.LNX.4.21.0010280032200.9401-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have ported ide-patch to 2.2.18-17 and I'm now backporting
2.4.0 changes. New VIA, SLC, OSB4 drivers and MANY other things
are already there.I hope that final 2.2.18-ide-patch will have
IDE functionality equal to this in 2.4.0-test10...

Here is a snapshot (it's not thoroughly audited and tested):
	http://republika.pl/bkz/ide.2.2.18-17.all.20001027.patch.bz2

And please cut that bullshit about ide-patch 2.2.x being unmantained.
I don't use 2.2.x kernels anymore so I don't do ide-patches for pre
kernels. But there will be patches for stable 2.2.x. (Although it's
a real pain - I hate doing backporting instead of new stuff).

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
