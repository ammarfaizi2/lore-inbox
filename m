Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267777AbTAMDaO>; Sun, 12 Jan 2003 22:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbTAMDaO>; Sun, 12 Jan 2003 22:30:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17935 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267777AbTAMDaN>; Sun, 12 Jan 2003 22:30:13 -0500
Date: Sun, 12 Jan 2003 22:36:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.5x can't find my printer
In-Reply-To: <Pine.LNX.4.33L2.0301102107420.19983-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1030112223412.17657D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Randy.Dunlap wrote:

> | > Are you expecting to see the "lp0" line also?
> |
> | I'd settle for a usable device, that isn't happening. I'd believe I need
> | to change config, but I'm at a loss for what.
> 
> Well, you could try disabling CONFIG_PNP to see if that works
> for you.  It does for me, but that doesn't mean much on a different
> system with different configs.

Thank you, I'll try that. I'm sure it has implications WRT the ISA sound
card, but clearly the starting point is to isolate the problem code
combination.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

