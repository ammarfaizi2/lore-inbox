Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267519AbTACNdQ>; Fri, 3 Jan 2003 08:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbTACNdQ>; Fri, 3 Jan 2003 08:33:16 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:38663 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267519AbTACNdP>; Fri, 3 Jan 2003 08:33:15 -0500
Message-ID: <3E159336.F249C2A1@aitel.hist.no>
Date: Fri, 03 Jan 2003 14:42:14 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
References: <Pine.LNX.4.10.10301022110580.421-100000@master.linux-ide.org> <1041596161.1157.34.camel@fly> <3E158738.4050003@walrond.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> 
> Yes but....
> 
> I develop computer games. The last one I did took a team of 35 people 2
> years and cost $X million to develop.
> 
> Please explain how I could do this as free software, while still feeding
> my people? 

> Am I a bad person charging for my work?
No.
> 
> Really - I want to understand so I too can join this merry band of happy
> people giving everything away for free!
> 
Nobody give everything away from free.  Free software, in particular,
runs
on boxes that cost money.  And people sell service and support.

The problem with nvidia isn't that they charge money.  The problem
is that their product comes with strange restrictions.  

Everybody accepts that a nvidia cards cost money - chips and boards
certainly aren't free.  They even provide drivers for their card
for free.  They can trivially do this because they make their
money on selling the hardware.

The problems are:
1) The drivers are closed-source, so we can't fix the bugs.  (Yes,
   there are bugs, and no, nvidia don't fix them immediately.  So
   it'd be nice for us who understand C to fix this ourselves.
   Releasing the code don't won't cost nvidia because they aren't
   making money on it.  They might actually sell _more_ hardware
   if they released the code.  So keeping it secret don't make sense
   even from a extreme greediness viewpoint.  Such a driver can't
   be made to work with a competing product either with a few tweaks.

2) Still, they _may_ have reasons not to release the code, perhaps
   a patended algorithm or some such.  They could at least release the
   specs for their card, so a free driver could be written from scratch.
   But they don't do that either - strange.  Some manufacturers _do_
   this, with no ill effects.  They get a slightly bigger market because
   their equipment is ok with the free software world.  

This is very much like selling cars were the gas tank is locked, and
you don't have the key.  The gas stations have keys, but only
some of them.  So you can't fill anywhere.  
Or a tv that don't work on thursdays. Silly in the extreme,
annoying for the user and no benefit for the manufacturer.

Helge Hafting
