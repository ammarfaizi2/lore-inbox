Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265813AbRF2Jgc>; Fri, 29 Jun 2001 05:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbRF2JgW>; Fri, 29 Jun 2001 05:36:22 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:29907 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S265813AbRF2JgN>; Fri, 29 Jun 2001 05:36:13 -0400
Message-ID: <3B3C4CB4.6B3D2B2F@kegel.com>
Date: Fri, 29 Jun 2001 02:39:00 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: O_DIRECT please; Sybase 12.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At work I had to sit through a meeting where I heard
the boss say "If Linux makes Sybase go through the page cache on
reads, maybe we'll just have to switch to Solaris.  That's
a serious performance problem."
All I could say was "I expect Linux will support O_DIRECT
soon, and Sybase will support that within a year."  

Er, so did I promise too much?  Andrea mentioned O_DIRECT recently
( http://marc.theaimsgroup.com/?l=linux-kernel&m=99253913516599&w=2,
 http://lwn.net/2001/0510/bigpage.php3 )
Is it supported yet in 2.4, or is this a 2.5 thing?

And what are the chances Sybase will support that flag any time
soon?  I just read on news://forums.sybase.com/sybase.public.ase.linux
that Sybase ASE 12.5 was released today, and a 60 day eval is downloadable
for NT and Linux.  I'm downloading now; it's a biggie.

It supports raw partitions, which is good; that might satisfy my
boss (although the administration will be a pain, and I'm not
sure whether it's really supported by Dell RAID devices).
I'd prefer O_DIRECT :-(

Hope somebody can give me encouraging news.

Thanks,
Dan
