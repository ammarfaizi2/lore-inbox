Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTBTWY1>; Thu, 20 Feb 2003 17:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbTBTWY0>; Thu, 20 Feb 2003 17:24:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1665 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S267189AbTBTWYI>;
	Thu, 20 Feb 2003 17:24:08 -0500
Subject: Re: 2.5.60 cheerleading...
From: "Timothy D. Witham" <wookie@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul Larson <plars@linuxtestproject.org>,
       John Bradford <john@grabjohn.com>, davej@codemonkey.org.uk,
       edesio@ieee.org, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, edesio@task.com.br
In-Reply-To: <20030213213850.GA22037@gtf.org>
References: <200302131823.h1DINeZh016257@darkstar.example.net>
	 <1045170999.28493.57.camel@plars>  <20030213213850.GA22037@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1045780188.1429.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 14:29:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about getting back on the thread late was off doing boring
management stuff.

But this is what PLM/STP does but right now it doesn't bother
to send the results to any list.

http://www.osdl.org/projects/26lnxstblztn/results/

Tim


On Thu, 2003-02-13 at 13:38, Jeff Garzik wrote:
> On Thu, Feb 13, 2003 at 03:16:29PM -0600, Paul Larson wrote:
> > Ideally, there should be no waiting around for replies.  The message is
> > sent, he starts whatever build/boot test cycle, checks for replies when
> > he's done and ready to release.  If nothing looks urgent enough to hold
> > it up, then he pushes the release.  I still don't see how this adds any
> > kind of terrible delay.
> 
> Outside suggestions to "improve" Linus's workflow usually fall upon deaf
> ears...
> 
> IMO to accomplish your goals, set up a test box with BitKeeper,
> constantly pulling and testing the latest 2.5.x BK trees.  If they
> crash, send full info to lkml.
> 
> Enough crash messages, and people will know automatically whether or not
> the kernel is good... and Linus didn't have to be bothered at all.
> 
> 	Jeff
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

