Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311401AbSCMWTG>; Wed, 13 Mar 2002 17:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSCMWS4>; Wed, 13 Mar 2002 17:18:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61961 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311401AbSCMWSp>; Wed, 13 Mar 2002 17:18:45 -0500
Date: Wed, 13 Mar 2002 17:17:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <72300000.1016049163@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.3.96.1020313171524.5467B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Dave McCracken wrote:

> 
> --On Wednesday, March 13, 2002 02:41:52 PM -0500 Bill Davidsen
> <davidsen@tmr.com> wrote:
> 
> > Let me mention this again... The IBM release of NGPT states that Linus has
> > approved the inclusion of the NGPT patches in the mainline kernel. Will
> > this be in 2.4.19 release? I've been running 2.4.17 for NGPT, haven't
> > tried 2.4.19 other than to see the patch didn't apply).
> 
> The 2.4 patch needed for NGPT was accepted by Marcelo and is in 2.4.19-pre3.

Good info, thanks! I hand edited the 2.4.17 patch to 2.4.18, but 19-pre2
didn't apply and I ran out of time about 1am this morning;-) When pre3
settles down a bit I'll use that as a base.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

