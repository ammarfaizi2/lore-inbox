Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTICXeC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTICXeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:34:02 -0400
Received: from mail.webmaster.com ([216.152.64.131]:55257 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264331AbTICXdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:33:47 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Pascal Schmidt" <der.eremit@email.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Driver Model
Date: Wed, 3 Sep 2003 16:33:44 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAENCGDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0309040049490.5139-100000@neptune.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 3 Sep 2003, David Schwartz wrote:

> > If the GPL_ONLY stuff is a license enforcement scheme, the DMCA
> > prohibits you from removing it.

> -ENOTUSCITIZEN

	In that case, there is more than likely nothing that prevents you from
doing whatever you want.

> > If the GPL_ONLY stuff is not a license enforcement scheme, nothing
> > prohibits you from stamping your module GPL when it's not.

> I'd say its up to the lawyers and judges to find out whether having
> MODULE_LICENSE("GPL") in a module means anything legally. It might
> mean "I promise this module is made from GPL source", but it might
> also mean nothing.

	Probably so.

> > However, the GPL (section 2b) prohibits you from imposing any
> > restrictions other than those in the GPL itself.

> Section 2b) in the file COPYING in the root dir of the kernel source
> does not talk about restrictions. Are we talking about the same version
> of the GPL?

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

	In other words, if you want to distribute the Linux kernel, you must
license it under the terms of the GPL. You may not impose additional
restrictions because if you do, you're not causing it to be distribute under
the terms of "this License".

	So if I download the Linux kernel from somewhere, someone distributed it to
me. Hence, if they complied with the GPL, I am under only the obligations
imposed by the GPL.

> > The GPL contains no restrictions that
> > apply to mere use and the GPL_ONLY stuff affects use, so it can't be a
> > license restriction, hence there is no restriction to enforce.

> The GPL doesn't even cover use of the "product". It covers modification
> and redistribution.

	It does cover use. Specifically, it permits unrestriced use. If you
received GPL'd code, you have the unrestricted right to use it. That's what
section 2b says.

> Well, it is still an open question whether kernel modules are derived
> works or not, especially since we don't have a stable kernel ABI and
> therefore modules have to use part of the kernel source (headers) and
> module writers have to study kernel code to write their modules (since
> there is no official complete documentation about functions in the
> kernel).

	Non-issue. I'm talking about your rights to *use* the kernel.

> If modules are derived works, then legally, following the GPL, they
> must be GPL too and GPL_ONLY is no problem but pointless.

	You must not be reading the same GPL I am. Can you please cite to me the
section that requires derived works to be placed under the GPL. I can't find
it.

> Seems to me you could say GPL_ONLY is a way of the developer saying
> "I consider your stuff to be a derived work if you use this symbol".
> Ask a lawyer whether that's their decision to make. ;)

	But that's not what it does. It prevents you from using the kernel in
certain ways. The GPL does not permit such usage restrictions. It also
restricts your ability to create and use derived works. The GPL similarly
does not permit such restrictions. The only restrictions the GPL allows a
distributed derived work to contain are those specifically imposed by the
GPL, and those restrictions only kick in at distribution.

	If there were distribution restrictions, you'd have an argument. But we are
talking about use restrictions.

> Apart from that, I fail to see how it is an addition restriction
> when you still have the right to remove all the GPL_ONLY stuff.

	You only have that right (in the United States) if the GPL_ONLY stuff is
*not* a copyright enforcement scheme.

> After
> all, the kernel is GPLed work, so you have the right to remove
> things and distribute the result. How is it a real restriction when
> the license allows you to remove it?

	Fine, so long as we all agree that the GPL_ONLY stuff is not a copyright or
license enforcement scheme and that evading or modifying it is not evading a
copyright/license enforcement scheme. In this case, you cannot argue that
the DMCA prohibits claiming a GPL license for purposes of compatability.

	DS


