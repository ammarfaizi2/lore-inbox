Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUIQUr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUIQUr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268987AbUIQUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:47:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17075 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269014AbUIQUrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:47:23 -0400
Date: Fri, 17 Sep 2004 21:40:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       Patrick Mochel <mochel@digitalimplant.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 2/2
Message-ID: <20040917194047.GE467@openzaurus.ucw.cz>
References: <1095332331.3855.161.camel@laptop.cunninghams> <20040916142847.GA32352@kroah.com> <1095373127.5897.23.camel@laptop.cunninghams> <20040916223539.GA16151@kroah.com> <1095374947.6537.34.camel@laptop.cunninghams> <20040916230713.GA16403@kroah.com> <1095376793.5902.49.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095376793.5902.49.camel@laptop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ah, no, I've never seen this one, thanks.  But it looks sane, I don't
> > have a problem with it (sysfs will like it, it's not a suspend specific
> > patch at all.)
> 
> Antonio posted it to LKML last week IIRC, which is why I didn't include
> it in the device driver patches. Given Pavel's changes (again), I'm in
> two minds as to whether its needed. It's clearly the right thing to do,
> but not needed at the moment. Then again, as we noted already, the whole

If it is not needed right now, go for simple solution and drop
that patch. Interested people can find it in list archives.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

