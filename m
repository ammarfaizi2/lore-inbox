Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264331AbUEIKsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbUEIKsF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbUEIKsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 06:48:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8064 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264331AbUEIKsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 06:48:00 -0400
Date: Sun, 9 May 2004 11:53:11 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405091053.i49ArBnh000172@81-2-122-30.bradfords.org.uk>
To: Rene Rebe <rene@rocklinux-consulting.de>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, rock-user@rocklinux.org
In-Reply-To: <20040509.105253.26927810.rene@rocklinux-consulting.de>
References: <409BB334.7080305@pobox.com>
 <20040509.084923.558886277.rene@rocklinux-consulting.de>
 <200405090707.i49776Iv000342@81-2-122-30.bradfords.org.uk>
 <20040509.105253.26927810.rene@rocklinux-consulting.de>
Subject: Re: Distributions vs kernel development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Rene Rebe <rene@rocklinux-consulting.de>:
> Hi,
> 
> On: Sun, 9 May 2004 08:07:06 +0100,
>     John Bradford <john@grabjohn.com> wrote:
> > > Since other use this chance to propose already well known
> > > distributions
> > 
> > To be honest, why use a distribution at all, or if you do use one, why worry
> > about 'following' it after installation, instead of using it as a base from
> > which to do your own thing?
> 
> In this case you might want to know that ROCK Linux is not yet another
> distribution but a distribution build kit including and build system
> to rebuild the whole distribution in a sorted and clean manner.

I must admit, I haven't had chance to have a proper look at ROCK Linux yet.

> And no, it is not like Gentoo where you need to rebuild on each box or
> so.

I keep hearing about projects which I hope will be what you describe above
for ROCK Linux.  Unfortunately, I haven't found one that goes far enough in
that direction yet.  Maybe there just isn't the demand for it these days.

I think that's unfortunate - installing the very basic parts of a system from
source, GLIBC, GCC, init scripts, system logging programs, yes, that is still
probably difficult for many new users, and a distribution that holds their
hand whilst doing that would be great.  However, once the basic system is
installed, many, many of the applications people want to run are very easily
installed, requiring little more than ./configure, make, and make install.

On paper, it might seem like an order of magnitude more effort, but in the
medium to long term, I think users would simply not encounter anywhere near
the number of problems they do by simply installing a distribution from CD.

Linux has caused a big wave in the computer industry, and brought free, open
source software to the attention of many people, but I think that even now,
much of the industry is, to a certain extent, trying to treat it in the same
way as proprietrary software.

Selling free, open source software as boxed products with support for that
boxed product seems to have worked up until now, but I think we'll quickly see
a plateau in interest in Linux, hopefully followed by a new wave of companies
working differently, with little emphasis on methods inherited from the
proprietrary software industry.

John.
