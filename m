Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbSLSUvz>; Thu, 19 Dec 2002 15:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSLSUvy>; Thu, 19 Dec 2002 15:51:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3600 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266135AbSLSUvy>; Thu, 19 Dec 2002 15:51:54 -0500
Date: Thu, 19 Dec 2002 15:58:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Are working modules going to be in 2.6?
Message-ID: <Pine.LNX.3.96.1021219154713.29567A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have downloaded any number of modutil this and init-mod that, built them
static, rolled my own initrd files, and as far as I can tell it just
doesn't work with 2.5.48+.

I build my own 2.4 and early 2.5 setups, they boot, right up to the point
where the "improved" module setup comes in. Since then I have to build the
drivers in to get a boot. That's acceptable for a single test machine,
it's not desirable to build a kernel for every config I support instead of
just building a new initrd file for a new config. 

Is there any plan to get this working, or if a magician can make it work
perhaps publishing the spell?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

