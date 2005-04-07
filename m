Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVDGXf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVDGXf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVDGXf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:35:27 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:31238 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262615AbVDGXVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:21:02 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>, <debian-legal@lists.debian.org>,
       <linux-acenic@sunsite.dk>
Subject: RE: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Thu, 7 Apr 2005 16:20:50 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEPFCPAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <20050407161658.S32136@links.magenta.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 07 Apr 2005 16:20:03 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 07 Apr 2005 16:20:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Apr 07, 2005 at 01:26:17AM -0700, David Schwartz wrote:

> > If you believe the linker "merely aggregates" the object code for the
> > driver with the data for the firmware, I can't see how you can argue
> > that any linking is anything but mere aggregation. In neither case can
> > you separate the linked work into the two separate works and in both
> > cases the linker provides one work direct access to the other.

> You can indeed separate the firmware and the kernel into two separate
> works.  That's what people have been proposing as the solution to this
> problem.

> Also, "mere aggregation" is a term from the GPL.  You can read what
> it says there yourself.  But basically it's there so that people make
> a distinction between the program itself and other stuff that isn't
> the program.

	It's also there because the GPL can only apply to either works placed under
it by their authors and works that are legally classified as derivative. If
you merely aggregate two works, there is no derivation. The GPL is making
clear that it's not trying to exceed the scope of its authority (which is
copyright law).

> Without that mere aggregation clause, people might be claiming that
> text on a disk has to be GPLed because of emacs, or that postscript
> files have to be GPLed because of ghostscript, or more generally that
> arbitrary object FOO has to be GPLed because of gpled program BAR.

	They could, but they would still be wrong. Because if you "merely
aggregate" two works, the result is still two works that can each be under
their own license. The GPL is only making clear what is outside its
authority, but it does not set the scope of its own authority anyway.

> Put another way, what the linker does or doesn't do isn't really the
> issue.

	Well it is. The question is whether you can link two object files together
and distribute the result under the license of each independent file,
treating it like a disk with two files on it, rather than as a single work.

> People like to think that the linker is somehow special for copyright,
> but it's not.  Either the stuff being linked is protected by copyright
> even when it's not linked or it's not protected by copyright after it is
> linked.  If the license says something about linking then that matters,
> but only for cases where the code was protected by copyright even before
> it was linked.  And then linking only matters in the specific way that
> that license says it matters.

	Regardless of what the GPL says, there is a genuine question of whether
linking together file A and file B results in a file C that contains the two
separate works or is a single work that is derivative of both A and B. This
is important because of aspects of copyright law that the GPL acknowledges
explicitly but does not get to decide.

	DS


