Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSFUDVe>; Thu, 20 Jun 2002 23:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSFUDVd>; Thu, 20 Jun 2002 23:21:33 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37129 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316089AbSFUDVd>; Thu, 20 Jun 2002 23:21:33 -0400
Date: Thu, 20 Jun 2002 23:17:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.19-pre 8390.c NETDEV WATCHDOG
In-Reply-To: <Pine.LNX.3.96.1020620103442.7127A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.96.1020620231458.9650A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Bill Davidsen wrote:

> I have an old Athlon 1.4GHz system which must be able to speak 100baseT
> and 10base2 (thinnet coax). For the 10base2 I have an SMC-Elite16 card,
> and any attempt to transmit gives a NETDEV WATCH error and shows that the
> interrupt did not come back (/proc/interrupts).

Nevermind, replaced the hardware, put the board in an old 486 where it
runs. Something about the fast system seems not to work but I needed to
get it working so I put it in a slow system.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

