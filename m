Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290611AbSARGew>; Fri, 18 Jan 2002 01:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290612AbSARGem>; Fri, 18 Jan 2002 01:34:42 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:24024 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S290611AbSARGed>; Fri, 18 Jan 2002 01:34:33 -0500
From: "Guillaume Boissiere" <boissiere@mediaone.net>
To: linux-kernel@vger.kernel.org
Date: Fri, 18 Jan 2002 01:33:51 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  January 18, 2002
Message-ID: <3C477B7F.22875.11D4078A@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new and improved list, thanks to all the great feedback I have 
received from dozens of people.  Again, if there are any inaccuracies,
please let me know and I will do my best to correct it for next week.

For everyone's enjoyment, I have also put an online version, (with 
hyperlinks, yeah!) at:
http://people.ne.mediaone.net/boissiere/Status-18-Jan-2002.html 

Items in bold are new since last time.  Also, to avoid having the list
become too big over time, I have decided that I will only accept items 
that can be expected to be merged within the next 6 months (i.e. the 
end of June).

Enjoy!

-- Guillaume

-------------------------------------------------------------
Kernel 2.5 status  -  January 18th, 2002

Features:

o Merged     New scheduler for improved scalability        (Ingo Molnar, Davide Libenzi)
o Merged     Rewrite of the block IO (bio) layer           (Jens Axboe)
o Merged     New kernel device structure (kdev_t)          (Linus Torvalds, etc)
o Merged     Initial support for USB 2.0                   (David Brownell, Greg Kroah-Hartman, 
others)
* Pending    IDE layer update                              (Andre Hedrick)
* Pending    Finalize new device naming convention         (Linus Torvalds)
o Ready      Add User-Mode Linux (UML)                     (Jeff Dike)
* Ready      HDLC (High-level Data Link Control) update    (Krzysztof Halasa)
o Ready      Add ALSA (Advanced Linux Sound Architecture)  (ALSA team)
o <1 month   New kernel build system (kbuild 2.5)          (Keith Owens)
o <1 month   New kernel config system: CML2                (Eric Raymond)
* Beta       Add support for CPU clock/voltage scaling     (Erik Mouw, Dave Jones, Russell King, 
Arjan van de Ven)
* Beta       Serial driver restructure                     (Russell King)
o Beta       New driver API for Wireless Extensions        (Jean Tourrilhes)
o Beta       New IO scheduler                              (Jens Axboe)
* Beta       NAPI Network interrupt mitigation             (Jamal Hadi Salim, Robert Olsson, Alexey 
Kuznetsov)
o Beta       Add JFS (Journaling FileSystem from IBM)      (JFS team)
* Beta       Add XFS (A journaling filesystem from SGI)    (XFS team)
o Beta       New VM with reverse mappings                  (Rik van Riel)
o Beta       Add preempt kernel option                     (Robert Love)
o Beta       Add resheduling points to remove latency      (Andrew Morton)
o Beta       Build option for Linux Trace Toolkit (LTT)    (Karim Yaghmour)
o Beta       Better event logging for enterprise systems   (evlog team)
o Ongoing    Better support of high-end NUMA machines      (NUMA team)
o Alpha      Add Asynchronous IO (aio) support             (Ben LaHaise)
o Alpha      Integrate EVMS into kernel                    (EVMS team)
* Alpha      Overhaul PCMCIA support                       (David Woodhouse, David Hinds)
* Alpha      Replace old NTFS driver with NTFS TNG driver  (Anton Altaparmakov)
o Started    Rewrite of the framebuffer layer              (James Simmons)
o Started    New driver model & unified device tree        (Patrick Mochel)
o Started    Rewrite of the console layer                  (James Simmons)
o Started    More complete NetBEUI and 802.2 net stacks    (Arnaldo Carvalho de Melo)
o Draft #2   New lightweight library (klibc)               (Greg Kroah-Hartman)
o Draft #3   Replace initrd by initramfs                   (H. Peter Anvin, Al Viro)
o Planning   Change all drivers to new driver model        (All maintainers)
o Planning   Add thrashing control                         (Rik van Riel)
o Planning   Remove all hardwired drivers from kernel      (Alan Cox, etc)
o Planning   Porting all input devices over to input API   (James Simmons)
o Planning   Generic parameter/command line interface      (Keith Owens)

Cleanups:

* Ready      Per network protocol slabcache & sock.h       (Arnaldo Carvalho de Melo)
* Beta       file.h and INIT_TASK                          (Benjamin LaHaise)
* Started    Per filesystem slabcache & fs.h               (Daniel Phillips, Jeff Garzik)

