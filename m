Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131571AbQLLMsT>; Tue, 12 Dec 2000 07:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131753AbQLLMsK>; Tue, 12 Dec 2000 07:48:10 -0500
Received: from gate-hq.megaloman.sk ([194.1.174.252]:30704 "EHLO
	megaloman.megaloman.sk") by vger.kernel.org with ESMTP
	id <S131571AbQLLMsA>; Tue, 12 Dec 2000 07:48:00 -0500
Date: Tue, 12 Dec 2000 13:17:21 +0100 (CET)
From: Peter Hanecak <hanecak@megaloman.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.17 with Hedrick's IDE patch compiled with gcc-2.95.3-0.20000323
Message-ID: <Pine.LNX.4.21.0012121317020.14622-100000@megaloman.megaloman.sk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I saw announcement about new 2.2.18 release and notice about
newer compilers. So I'm writing ...

Since Sep 6 2000 I'm running kernel 2.2.17 with Andre Hedrick's IDE patch
(20000904) compiled with gcc-2.95.3-0.20000323 (RedHat package). I'm
runing it on Pentium III/650 MHz system with 256 MB of RAM, 4 disks and
one CD-ROM (two disk and CD-ROM are on regular IDE, one disk in on ATA),
old ES1688 based ISA sound card and  PCI 3c905B Cyclone etherrnet adapter.

I'm working mostly undex X windows (GNOME desktop).

Since then I did not encountered any crash except one - when one program
attempted to allocate A LOT of memory.

Also my "biggest" problem with my machine is that when I'm making big IO
with disks (copying BIG files - 10-100 MB), machine stops respondiong for
a socond (sound stop playing, mouse cursor responding, screen
redrawing). But after that everything continues fine.


Thanks to kernel developers for good work.


If anyone has questions I will be happe to answer.


Sincerely

Peter Hanecak

-- 
===================================================================
  Peter Hanecak <hanecak@megaloman.com>
  GPG pub.key: http://www.megaloman.com/gpg/hanecak-megaloman.txt
===================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
