Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422928AbWCXAW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422928AbWCXAW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422926AbWCXAW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:22:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7185 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422928AbWCXAW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:22:27 -0500
Date: Fri, 24 Mar 2006 01:22:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@sous-sol.org>
Subject: Re: 2.6.16.x will be a long-living kernel series
Message-ID: <20060324002225.GP22727@stusta.de>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060320120229.GB22317@stusta.de> <1142856322.3114.37.camel@laptopd505.fenrus.org> <20060320121207.GC22317@stusta.de> <1142859823.3114.39.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142859823.3114.39.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:03:42PM +0100, Arjan van de Ven wrote:
> On Mon, 2006-03-20 at 13:12 +0100, Adrian Bunk wrote:
> > On Mon, Mar 20, 2006 at 01:05:22PM +0100, Arjan van de Ven wrote:
> > > On Mon, 2006-03-20 at 13:02 +0100, Adrian Bunk wrote:
> > > > As proposed some time ago [1], I'll continue the 2.6.16.x series after 
> > > > 2.6.17 will be released.
> > > 
> > > 
> > > ehh are you doing this as part of the regular stable effort ? Or in
> > > parallel to that?
> > 
> > This seems to be the point I never manage to communicate correctly...
> > 
> > After 2.6.17 will be released, there will be the last regular 2.6.16.x 
> > kernel by Greg and Chris.
> 
> more like after 2.6.18, since they do 2 releases back nowadays

Unless I've misunderstood it, this isn't completely true.

They would do more releases if there are patches sent for them, but in 
practice there is only one release back really done.

> > I'll continue the 2.6.16.x series _after_ this last regular stable 
> > kernel.
> 
> ok
> 
> btw I don't really agree with your criteria, I would strongly suggest
> that you keep using the "stable" criteria.

Simple patches adding support for aditional hardware might be nice.
For stuff in a flux like SATA updates might be nice.

Time will tell.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

