Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbQLCGaj>; Sun, 3 Dec 2000 01:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbQLCGa3>; Sun, 3 Dec 2000 01:30:29 -0500
Received: from f231.law9.hotmail.com ([64.4.9.231]:34830 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129581AbQLCGaQ>;
	Sun, 3 Dec 2000 01:30:16 -0500
X-Originating-IP: [128.162.195.84]
From: "Saber Taylor" <aquabrake@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: lost dirs after fsck-1.18 (kt133, ide, dma, test10, test11)
Date: Sun, 03 Dec 2000 05:59:47 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F231OceuLyR1mDxJr5D0000c3f6@hotmail.com>
X-OriginalArrivalTime: 03 Dec 2000 05:59:47.0647 (UTC) FILETIME=[3DE084F0:01C05CEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well that's the last time I run a devel kernel with a nontest
system.  sigh.

Had one directory replaced with a different directory
and also a directory replaced with a file. Possible further
corruption.

I don't think I lost the directories until I did a 'fsck -y'
on the partition. Something to remember.

If anyone has advice on recovering the directories other than
the following links, I'm all ears:

http://www.datafoundation.org/lde/
http://www.linuxdoc.org/HOWTO/mini/Ext2fs-Undeletion.html
(last updated February 1999)
http://www.linuxdoc.org/HOWTO/mini/Ext2fs-Undeletion-Dir-Struct/


Saber Taylor
_____________________________________________________________________________________
Get more from the Web.  FREE MSN Explorer download : http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
