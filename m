Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWAZH6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWAZH6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 02:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWAZH6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 02:58:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26800 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932098AbWAZH6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 02:58:41 -0500
Date: Thu, 26 Jan 2006 08:58:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060126075807.GA1617@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz> <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz> <20060124222044.GG2449@redhat.com> <20060124223328.GC1602@elf.ucw.cz> <20060124223834.GH2449@redhat.com> <20060124224437.GA2007@elf.ucw.cz> <20060126020926.GR5501@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060126020926.GR5501@mail>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 25-01-06 21:09:27, Jim Crilly wrote:
> On 01/24/06 11:44:37PM +0100, Pavel Machek wrote:
> > On Út 24-01-06 17:38:34, Dave Jones wrote:
> > >  > We'll of course try to get the interface right at the first
> > >  > try. OTOH... if wrong interface is in kernel for a month, I do not
> > >  > think it is reasonable to keep supporting that wrong interface for a
> > >  > year before it can be removed. One month of warning should be fair in
> > >  > such case...
> > > 
> > > Users want to be able to boot between different kernels.
> > > Tying functionality to specific versions of userspace completely
> > > screws them over.
> > 
> > Well, by the time we have any _users_ interface should be
> > stable. Actually I believe interface will be stable from day 0, but...
> >
> 
> I'm sure gregkh thought the same thing with about sysfs and udev and we've
> seen how well that's worked out...

Quite well, I'd say. But whats your alternative, just stop adding
interfaces to the kernel? Oops...
							Pavel
-- 
Thanks, Sharp!
