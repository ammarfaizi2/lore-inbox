Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288245AbSAQHOK>; Thu, 17 Jan 2002 02:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAQHOA>; Thu, 17 Jan 2002 02:14:00 -0500
Received: from chmls16.mediaone.net ([24.147.1.151]:33199 "EHLO
	chmls16.mediaone.net") by vger.kernel.org with ESMTP
	id <S288245AbSAQHNt>; Thu, 17 Jan 2002 02:13:49 -0500
From: "Guillaume Boissiere" <boissiere@mediaone.net>
To: linux-kernel@vger.kernel.org
Date: Thu, 17 Jan 2002 02:13:11 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  January 17, 2001
Message-ID: <3C463337.24593.CD1AD57@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen several times on this list people wondering what features
were in the works for 2.5 and what the status of the development was.
I did some grepping on the archive and put together a list of things 
that have been discussed / worked on for 2.5 over the past year or so.  

It's probably pretty incomplete and full of errors at this point but 
I'll be happy to update it if you send me email.

o Merged   New scheduler for improved scalability       (Ingo Molnar)
o Merged   Rewrite of the block IO (bio) layer          (Jens Axboe)
o Merged   New kernel device structure (kdev_t)         (Linus Torvalds)
o Merged   Initial support for USB 2.0                  (Greg KH, others)
o Ready    Add User-Mode Linux (UML)                    (Jeff Dike)
o Ready    Add ALSA (Advanced Linux Sound Architecture) (ALSA team)
o Ready    IDE layer update                             (Andre Hedrick)
o <1 month New kernel build system (kbuild 2.5)         (Keith Owens)
o <1 month New kernel config system: CML2               (Eric Raymond)
o Beta     New driver API for Wireless Extensions       (Jean Tourrilhes)
o Beta     New IO scheduler                             (Jens Axboe)
o Beta     Add JFS (Journaling FileSystem from SGI)     (JFS team)
o Beta     New VM with reverse mappings                 (Rik van Riel)
o Beta     Add preempt kernel option                    (Robert Love)
o Beta     Add resheduling points to remove latency     (Andrew Morton)
o Beta     Build option for Linux Trace Toolkit (LTT)   (Karim Yaghmour)
o Beta     Better event logging for enterprise systems  (evlog team)
o Ongoing  Better support of high-end NUMA machines     (NUMA team)
o Alpha    Add Asynchronous IO (aio) support            (Ben LaHaise)
o Alpha    Integrate EVMS into kernel                   (EVMS team)
o Started  Rewrite of the framebuffer layer             (James Simmons)
o Started  New driver model & unified device tree       (Patrick Mochel)
o Started  Rewrite of the console layer                 (James Simmons)
o Started  More complete NetBEUI and 802.2 net stacks   (Alnaldo C de M)
o Draft #2 New lightweight library (klibc)              (Greg KH)
o Draft #3 Replace initrd by initramfs                  (hpa, Al Viro)
o Planning Change all drivers to new driver model       (All maintainers)
o Planning Add thrashing control                        (Rik van Riel)
o Planning Remove all hardwired drivers from kernel     (Alan Cox, etc)
o Planning Porting all input devices over to input API  (James Simmons)
o Planning generic parameter/command line interface     (Keith Owens)

I hope this is helpful. Enjoy!

-- gb

----------------------------------------
Guillaume Boissiere

