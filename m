Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWCUUoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWCUUoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWCUUoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:44:39 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:59276 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932367AbWCUUoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:44:38 -0500
Date: Tue, 21 Mar 2006 21:44:35 +0100
From: Sander <sander@humilis.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sander <sander@humilis.net>, Mark Lord <liml@rtr.ca>,
       Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060321204435.GE25066@favonius>
Reply-To: sander@humilis.net
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org> <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org>
X-Uptime: 21:33:22 up 19 days,  1:43, 31 users,  load average: 2.24, 2.82, 2.66
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote (ao):
> > I was not able to let 2.6.16-rc6-mm2 crash yet.
> > 
> > I'll test 2.6.16-rc6-mm1 now.
> 
> Yup, narrowing down where exactly things go south is the way to do it.

2.6.16-rc6-mm1 is as stable as 2.6.16-rc6-mm2 with my simple testcase.

Is there a quick patch to suspect, or should I narrow down some more per
Andrew's instructions?

-- 
Humilis IT Services and Solutions
http://www.humilis.net
