Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135689AbRDZRNA>; Thu, 26 Apr 2001 13:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135702AbRDZRMu>; Thu, 26 Apr 2001 13:12:50 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:52716 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S135688AbRDZRMd>; Thu, 26 Apr 2001 13:12:33 -0400
Date: Thu, 26 Apr 2001 13:12:33 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: memory problems?
Message-ID: <Pine.LNX.4.10.10104261311380.27506-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.4.2ac23 (can't run 2.4.3, messes up my quota system)
glibc 2.1.3, intel providence PR440FX mobo, intel etherexpress 100B
onboard, RAM is 128MBx3.

Started getting the following errors:

VM: bad swap entry 00002000
Unused swap offset entry in swap_dup 00002000
memory.c:84: bad pmd 00002000.

got multiples of all of the above.
also got a bunch of eth0: Transmit timed out: status f048  0000 at
387774/387804 command 0001a000.
and i also got some programs segfaulting.

Swap is 128MB. "free" does not show system using any swap.

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


