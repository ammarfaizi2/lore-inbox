Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTIDBzm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbTIDBy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:54:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11792
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264519AbTIDBww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:52:52 -0400
Date: Wed, 3 Sep 2003 18:37:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pascal Schmidt <der.eremit@email.de>
cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: RE: Driver Model
In-Reply-To: <Pine.LNX.4.44.0309040049490.5139-100000@neptune.local>
Message-ID: <Pine.LNX.4.10.10309031836080.13722-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pascal,

SUPER HIGH FIVE!

You have made the obvious clear, and most will not even follow or listen.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 4 Sep 2003, Pascal Schmidt wrote:

> On Wed, 3 Sep 2003, David Schwartz wrote:
> 
> > If the GPL_ONLY stuff is a license enforcement scheme, the DMCA 
> > prohibits you from removing it.
> 
> -ENOTUSCITIZEN
> 
> > If the GPL_ONLY stuff is not a license enforcement scheme, nothing 
> > prohibits you from stamping your module GPL when it's not.
> 
> I'd say its up to the lawyers and judges to find out whether having
> MODULE_LICENSE("GPL") in a module means anything legally. It might
> mean "I promise this module is made from GPL source", but it might
> also mean nothing.
> 
> > However, the GPL (section 2b) prohibits you from imposing any
> > restrictions other than those in the GPL itself.
> 
> Section 2b) in the file COPYING in the root dir of the kernel source
> does not talk about restrictions. Are we talking about the same version
> of the GPL?
> 
> > The GPL contains no restrictions that
> > apply to mere use and the GPL_ONLY stuff affects use, so it can't be a
> > license restriction, hence there is no restriction to enforce.
> 
> The GPL doesn't even cover use of the "product". It covers modification
> and redistribution.
> 
> Well, it is still an open question whether kernel modules are derived
> works or not, especially since we don't have a stable kernel ABI and
> therefore modules have to use part of the kernel source (headers) and
> module writers have to study kernel code to write their modules (since
> there is no official complete documentation about functions in the 
> kernel).
> 
> If modules are derived works, then legally, following the GPL, they
> must be GPL too and GPL_ONLY is no problem but pointless.
> 
> Seems to me you could say GPL_ONLY is a way of the developer saying
> "I consider your stuff to be a derived work if you use this symbol".
> Ask a lawyer whether that's their decision to make. ;)
> 
> Apart from that, I fail to see how it is an addition restriction
> when you still have the right to remove all the GPL_ONLY stuff. After
> all, the kernel is GPLed work, so you have the right to remove
> things and distribute the result. How is it a real restriction when
> the license allows you to remove it?
> 
> -- 
> Ciao,
> Pascal
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

