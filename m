Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRAAET6>; Sun, 31 Dec 2000 23:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbRAAETs>; Sun, 31 Dec 2000 23:19:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22542 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131505AbRAAETf>; Sun, 31 Dec 2000 23:19:35 -0500
Subject: Re: 2.4.0-prerelease & 2048-byte FAT sectors
To: thoth@leapdragon.net (Desert Dragon)
Date: Mon, 1 Jan 2001 03:51:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20001231201053.thoth@leapdragon.net> from "Desert Dragon" at Dec 31, 2000 08:10:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Cw0L-0000RZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just installed 2.4.0-prerelease, and it looks like FAT
> filesystems on hardware 2048-byte sectors are still not
> working.
> Are there any plans to fix this, or should I consider

Jens was fixing it for CD-ROM devices. I dont know if anyone was fixing
for M/O devices currently

> such devices obsolete? I'm keeping 2.2.17 around and

Far from obsolete - its a bug. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
