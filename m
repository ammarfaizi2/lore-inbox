Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWCIWMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWCIWMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWCIWMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:12:53 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:50183 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751791AbWCIWMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:12:52 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Thu, 9 Mar 2006 14:11:44 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEPJKJAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <161717d50603090713r50471974tb0089863324e88c0@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 09 Mar 2006 14:08:08 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 09 Mar 2006 14:08:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Right. Copyright law doesn't allow me to demand royalties from the
> people who read my dropped-from-airplane poem.

	Right. In other words, simply by lawfully receiving the work, they have the
right to the normal, expected use of that work.

> Copyright law *does*
> say that I can prevent people from copying my dropped-from-airplane
> poem and re-publishing it, however.

	True, but this discussion wasn't about redistribution.

> Copyright law also absolutely
> gives me monopoly power over derivitive works - you can't even create
> a work derived from my dropped-from-airplane poem without my
> permission, much less distribute one.

	No, that's not true on two counts.

	First, your last part "much less distribute one" is utterly false.
Copyright law does not give you any special rights to restrict the
distribution of derivative works.

	Second, your first part, that it gives you monopoly power over the creation
of derivative works is also false. First sale and fair use can give people
the right to create derivative works.

> But let's not keep torturing the analogy. We're talking about
> software, in particular driver software which is presumably (and here
> a court gets to decide whether the presumption is true, not driver
> authors) a derived work of the kernel on which it depends. Many, many
> kernel developers have repeatedly stated their reservations of their
> rights under copyright law and the GPL with regard to derived works on
> this forum and elsewhere.

	If the driver is not a derived work of the kernel, then we agree you are
free to create and distribute it, I think. If the driver contains only as
much of the kernel as it must in order to be created at all, then under at
least United States precedent, it is not considered a derived work.

	Copyright only applies when there's more than one way to do the same thing.
If it is impossible to create a Linux kernel driver without taking X, then X
cannot be protected by copyright because it is practically necessary. (And
courts have never been impressed by arguments like "you don't need to create
a driver really" or "you can create a driver for another operating system"
because these are ways to express other ideas, not other ways to express the
same idea.)

	You cannot copyright an idea. "A Foo2000 SCSI driver for Linux 2.6" is an
*idea*. So you cannot argue that you have copyright on every practically
possible way to create such a driver.

	This argument could only apply in a case where the driver author took more
of the kernel than they practically had to in order to express the idea they
wished to express. (See Lexmak v. Static Controls, for example.)

	DS


