Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTKRNIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTKRNIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:08:45 -0500
Received: from gprs147-139.eurotel.cz ([160.218.147.139]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262225AbTKRNIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:08:42 -0500
Date: Tue, 18 Nov 2003 10:59:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031118095912.GA233@elf.ucw.cz>
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311112021.34631.andrew@walrond.org> <20031111235215.GA22314@work.bitmover.com> <200311131010.27315.andrew@walrond.org> <20031113162712.GA2462@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113162712.GA2462@work.bitmover.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I could make some comment about this being a good example of one of
> > > the zillion little problems we've had to solve but if I go there it's
> > > going to start a flame war.  So I won't.  I will note that none of the
> > > solutions proposed come close to being acceptable, they all fail on NFS
> > > and on SMB shares.  And they don't cascade properly as HPA has noted.
> > 
> > Absolutely. Bk is, undeniably, brilliant, and would solve all these problems 
> > at a stroke, except that the open source community cannot with good 
> > conscience exclude *anyone* from being able to access the sources.
> 
> But noone is excluded from having access to the sources.
> 
> I suppose it sounds like we don't want to give out more free engineering
> but let's put things into perspective.  The CVS server has about 6
> users.

I do not know where you got that number, but its wrong. You cited 6
unique IP addresses... I certainly did updates from more than
_that_. But I use time rsync -zav --delete
rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5 ., so I'm
probably not counted in your statistics.

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
