Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290551AbSARAYM>; Thu, 17 Jan 2002 19:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290552AbSARAYG>; Thu, 17 Jan 2002 19:24:06 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:41468 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S290551AbSARAXs>; Thu, 17 Jan 2002 19:23:48 -0500
Message-Id: <5.1.0.14.2.20020118002237.00af5be0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 18 Jan 2002 00:23:43 +0000
To: "Guillaume Boissiere" <boissiere@mediaone.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [STATUS 2.5]  January 17, 2001
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C463337.24593.CD1AD57@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to add my pet point to the list.

o Alpha Replace old NTFS driver with NTFS TNG driver

Cheers,

Anton

At 07:13 17/01/02, Guillaume Boissiere wrote:
>I've seen several times on this list people wondering what features
>were in the works for 2.5 and what the status of the development was.
>I did some grepping on the archive and put together a list of things
>that have been discussed / worked on for 2.5 over the past year or so.
>
>It's probably pretty incomplete and full of errors at this point but
>I'll be happy to update it if you send me email.
>
>o Merged   New scheduler for improved scalability       (Ingo Molnar)
>o Merged   Rewrite of the block IO (bio) layer          (Jens Axboe)
>o Merged   New kernel device structure (kdev_t)         (Linus Torvalds)
>o Merged   Initial support for USB 2.0                  (Greg KH, others)
>o Ready    Add User-Mode Linux (UML)                    (Jeff Dike)
>o Ready    Add ALSA (Advanced Linux Sound Architecture) (ALSA team)
>o Ready    IDE layer update                             (Andre Hedrick)
>o <1 month New kernel build system (kbuild 2.5)         (Keith Owens)
>o <1 month New kernel config system: CML2               (Eric Raymond)
>o Beta     New driver API for Wireless Extensions       (Jean Tourrilhes)
>o Beta     New IO scheduler                             (Jens Axboe)
>o Beta     Add JFS (Journaling FileSystem from SGI)     (JFS team)
>o Beta     New VM with reverse mappings                 (Rik van Riel)
>o Beta     Add preempt kernel option                    (Robert Love)
>o Beta     Add resheduling points to remove latency     (Andrew Morton)
>o Beta     Build option for Linux Trace Toolkit (LTT)   (Karim Yaghmour)
>o Beta     Better event logging for enterprise systems  (evlog team)
>o Ongoing  Better support of high-end NUMA machines     (NUMA team)
>o Alpha    Add Asynchronous IO (aio) support            (Ben LaHaise)
>o Alpha    Integrate EVMS into kernel                   (EVMS team)
>o Started  Rewrite of the framebuffer layer             (James Simmons)
>o Started  New driver model & unified device tree       (Patrick Mochel)
>o Started  Rewrite of the console layer                 (James Simmons)
>o Started  More complete NetBEUI and 802.2 net stacks   (Alnaldo C de M)
>o Draft #2 New lightweight library (klibc)              (Greg KH)
>o Draft #3 Replace initrd by initramfs                  (hpa, Al Viro)
>o Planning Change all drivers to new driver model       (All maintainers)
>o Planning Add thrashing control                        (Rik van Riel)
>o Planning Remove all hardwired drivers from kernel     (Alan Cox, etc)
>o Planning Porting all input devices over to input API  (James Simmons)
>o Planning generic parameter/command line interface     (Keith Owens)
>
>I hope this is helpful. Enjoy!
>
>-- gb
>
>----------------------------------------
>Guillaume Boissiere
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

