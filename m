Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129742AbQK0XjQ>; Mon, 27 Nov 2000 18:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129684AbQK0XjG>; Mon, 27 Nov 2000 18:39:06 -0500
Received: from srvr2.telecom.lt ([212.59.0.1]:20999 "EHLO mail.takas.lt")
        by vger.kernel.org with ESMTP id <S129639AbQK0XjC>;
        Mon, 27 Nov 2000 18:39:02 -0500
Reply-To: <nerijus@freemail.lt>
From: "Nerijus Baliunas" <nerijus@users.sourceforge.net>
To: <linux-kernel@vger.kernel.org>
Subject: bread in fat_access failed
Date: Tue, 28 Nov 2000 01:01:56 +0200
Message-ID: <MPBBJGBJAHHNDMMBBLMIEEHPEHAB.nerijus@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1368.975364537@kao2.melbourne.sgi.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get a lot of such messages:

Nov 28 01:00:28 sargis kernel: bread in fat_access failed
Nov 28 01:00:28 sargis kernel: attempt to access beyond end of device
Nov 28 01:00:28 sargis kernel: 02:00: rw=0, want=5, limit=4
Nov 28 01:00:28 sargis kernel: dev 02:00 blksize=512 blocknr=9 sector=9 size=512
count=1

What do they mean? Problems with hdd?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
