Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSHGSUs>; Wed, 7 Aug 2002 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSHGSUi>; Wed, 7 Aug 2002 14:20:38 -0400
Received: from pensacola.gci.com ([205.140.80.79]:12814 "EHLO
	pensacola.gci.com") by vger.kernel.org with ESMTP
	id <S318793AbSHGST5>; Wed, 7 Aug 2002 14:19:57 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA31509E4BE14@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: ethtool documentation
Date: Wed, 7 Aug 2002 10:16:26 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
>
> Also, if you want to destroy Ethernet, mucking with the MAC address
> is an easy way to do it.

Yeah, I remember the time that I set all the prefixes in my lab for the
stations I had running WinX to BE:DE:AD, and Linux to FE:ED:B0,
and the station addresses from 1-24. 

That way a quick arp on the router would tell me which of my stations were
booted into Windows, and which were booted into Linux.

<sarcasm>
Gosh, that wasn't helpful at all to me, and sure b0rked up "Ethernet"
</sarcasm>

If you don't like it, don't use it.  Please don't try to take that
functionality away from the rest of the world, because we find it
useful.  And sometimes it's required.


Leif


