Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131663AbRCOLEe>; Thu, 15 Mar 2001 06:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131659AbRCOLEY>; Thu, 15 Mar 2001 06:04:24 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:61838 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131663AbRCOLEM>; Thu, 15 Mar 2001 06:04:12 -0500
Message-Id: <5.0.2.1.2.20010315110131.00a4c620@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 15 Mar 2001 11:03:22 +0000
To: Dragan Milenkovic <tyrant@galeb.etf.bg.ac.yu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Utility for re-patritioning
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103151109420.13929-100000@galeb.etf.bg.ac.y
 u>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:17 15/03/01, Dragan Milenkovic wrote:
>Since Linus has said that we need Swap = 2xRAM,
>and I bought some RAM, I need to enlarge my swap partition.
>Which utility should I use to resize my (ext2) partitions
>(possibly without data corruption:) ?

Have a look at gnu parted (ftp.gnu.org/gnu/parted/)

Regards,

         Anton


>--
>Dragan
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

