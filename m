Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290048AbSAQRCo>; Thu, 17 Jan 2002 12:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290051AbSAQRCe>; Thu, 17 Jan 2002 12:02:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59404 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290048AbSAQRCZ>; Thu, 17 Jan 2002 12:02:25 -0500
Date: Thu, 17 Jan 2002 12:01:43 -0500
Message-Id: <200201171701.MAA02161@gatekeeper.tmr.com>
To: landley@trommello.org
Subject: Re: KDE hang with 2.4.18-pre3-ac2
In-Reply-To: <20020117025432.INGX20810.femail29.sdc1.sfba.home.com@there>
In-Reply-To: <Pine.LNX.3.96.1020116121752.28369J-100000@gatekeeper.tmr.com>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020117025432.INGX20810.femail29.sdc1.sfba.home.com@there> you write:
| On Wednesday 16 January 2002 12:20 pm, Bill Davidsen wrote:

| > Totally other problem. When my KDE won't launch tasks from the bar, it
| > will still work just fine otherwise, shutdown cleanly, etc. System is not
| > in any way hung, just that clicking the browser or terminal button doesn't
| > start a process, and if I bring up a menu from the bar, and try to start
| > something like moon phase, it also doesn't start.
| 
| Question: did you change your computer's hostname just before this happened?  
| (That can trigger this behavior.  When you change your box's hostname, you 
| have to exit and restart X.  If you ask me, it's a design flaw in X, which 
| thinks it's doing stuff through the network even when it isn't.  KDE isn't 
| helping by cacheing stuff, but it's going for performance...)

  Haven't changed the name this millenium. This is my personal box I use
to monitor systems at a site, and while it's not critical it's
production (which is why I can play). Didn't know that was a problem,
but I'd be unlikely to rename from X if I had to.

  If restarting KDE would have fixed it I would ignore the issue (once),
but no new KDE start did any good until a reboot.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
