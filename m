Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWAZCKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWAZCKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWAZCKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:10:41 -0500
Received: from atpro.com ([12.161.0.3]:29700 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1751283AbWAZCKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:10:40 -0500
Date: Wed, 25 Jan 2006 21:09:27 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060126020926.GR5501@mail>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
	rjw@sisk.pl, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz> <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz> <20060124222044.GG2449@redhat.com> <20060124223328.GC1602@elf.ucw.cz> <20060124223834.GH2449@redhat.com> <20060124224437.GA2007@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060124224437.GA2007@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/06 11:44:37PM +0100, Pavel Machek wrote:
> On Út 24-01-06 17:38:34, Dave Jones wrote:
> >  > We'll of course try to get the interface right at the first
> >  > try. OTOH... if wrong interface is in kernel for a month, I do not
> >  > think it is reasonable to keep supporting that wrong interface for a
> >  > year before it can be removed. One month of warning should be fair in
> >  > such case...
> > 
> > Users want to be able to boot between different kernels.
> > Tying functionality to specific versions of userspace completely
> > screws them over.
> 
> Well, by the time we have any _users_ interface should be
> stable. Actually I believe interface will be stable from day 0, but...
>

I'm sure gregkh thought the same thing with about sysfs and udev and we've
seen how well that's worked out...

> 								Pavel

Jim.
