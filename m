Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279591AbRKMWP0>; Tue, 13 Nov 2001 17:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279630AbRKMWPQ>; Tue, 13 Nov 2001 17:15:16 -0500
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:36256 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S279591AbRKMWPH>;
	Tue, 13 Nov 2001 17:15:07 -0500
Message-ID: <3BF19C23.F45EBB50@randomlogic.com>
Date: Tue, 13 Nov 2001 14:18:11 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu> <200111132137.fADLbdW01289@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian wrote:
> 
> We've tried a number of boards for our application servers and the only UP
> AMD DDR board I trust right now is the Gigabyte GA-7DX.  They are rock
> solid.
> 
> Other AMD 761 boards may work, but I've made too many late night trips to
> the colo to stray from what I know works.  DDR support seems to be the
> breaking point on most boards.
> 

Another thing to remember about Athlons is they need power and cooling. I've seen many a system with either a cheap power supply or a poorly ventilated case,
and often both. Athlons WILL push the hardware harder, not to mention the power they suck down themselves, and need a power supply that can handle the load as
well as the fast switching transitions. They also require more cooling, and not just on the CPU, but also on the chipset and throughout the case.

My dual 1.4GHz (K7 Thunder) has 12 fans in it. My single 1.4GHz has 8. They both have 400W+ power supplies.

PGA
-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
