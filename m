Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbRABTxF>; Tue, 2 Jan 2001 14:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131617AbRABTwz>; Tue, 2 Jan 2001 14:52:55 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:30995 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131378AbRABTwk>; Tue, 2 Jan 2001 14:52:40 -0500
Date: 02 Jan 2001 20:02:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7t4FOruXw-B@khms.westfalen.de>
In-Reply-To: <E14D7Zj-00011M-00@the-village.bc.nu>
Subject: Re: Chipsets, DVD-RAM, and timeouts....
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.10.10012312252220.21836-300000@master.linux-ide.org> <E14D7Zj-00011M-00@the-village.bc.nu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 01.01.01 in <E14D7Zj-00011M-00@the-village.bc.nu>:

> > 	./drivers/ide/ide-cd.c
> > 	./drivers/ide/ide-cd.h
> >
> > 	Adds ATAPI DVD-RAM native read/write mode for any FS.
>
> Interesting to say the least. But..
>
> > 	mke2fs -b 2048 /dev/hdc
> > 	You must format to 2048 size blocks.
>
> FAT style FS doesnt support 2K blocks 8)

Dim memory tells me I once had a MO drive that used FAT on 2K blocks, and  
*some* versions of Linux supported it.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
