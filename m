Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTIDDCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTIDDCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:02:06 -0400
Received: from mail.webmaster.com ([216.152.64.131]:49381 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264620AbTIDDBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:01:43 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Pascal Schmidt" <der.eremit@email.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Driver Model
Date: Wed, 3 Sep 2003 20:01:20 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEOCGDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0309040317120.8368-100000@neptune.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, 3 Sep 2003, David Schwartz wrote:
>
> > In other words, if you want to distribute the Linux kernel, you must
> > license it under the terms of the GPL. You may not impose additional
> > restrictions because if you do, you're not causing it to be distribute
> > under the terms of "this License".
>
> Correct.
>
> > It does cover use.
>
> In section 0:
>
> Activities other than copying, distribution and modification are not
> covered by this License; they are outside its scope.

	So are you arguing that I can distribute a derived work from the Linux
kernel and attach a 'you may not use this unless you pay me $100' clause and
it would be enforceable?

> > Specifically, it permits unrestriced use. If you
> > received GPL'd code, you have the unrestricted right to use it. That's
> > what section 2b says.
>
> No, section 2b gives you the the right to copy, distribute, and modify
> the code (as the license only covers those rights, as per section 0) and
> no restrictions may be placed on those specific rights.

	If you are right, you've discovered a serious fundamental flaw in the GPL.
I can distribute code under the GPL and prohibit anyone from using derived
works, hence effectively removing their freedom to modify.

> > Non-issue. I'm talking about your rights to *use* the kernel.
>
> Well, I'm not buying the argument that the GPL has anything to say
> about usage.

	Then you have no right to usage. The preamble contradicts this, but I doubt
it's binding.

> > You must not be reading the same GPL I am. Can you please cite to me the
> > section that requires derived works to be placed under the GPL. I can't
> > find it.
>
> You quoted it yourself. 2b)
>
>     b) You must cause any work that you distribute or publish, that in
>     whole or in part contains or is derived from the Program or any
>     part thereof, to be licensed as a whole at no charge to all third
>     parties under the terms of this License.
>
> "work that ... is derived from the Program or any part thereof"

	This is only about works that you distribute or publish. We're talking
about using modules.

> > But that's not what it does. It prevents you from using the kernel in
> > certain ways. The GPL does not permit such usage restrictions.
>
> Lots of GPL'ed programs refuse to be used in certain ways. For example,
> fetchmail will refuse to run with a world-readable .fetchmailrc file.

	Yes, but nobody's arguing that these are license enforcement schemes or
that this is a license restriction. Nobody would complain if you removed
those restrictions. The question here is whether the GPL_ONLY stuff is a
copyright enforcement mechanism or license restriction. If we agree it's not
and anyone is free to circumvent or remove it, then there's nothing to
dispute.

> > It also restricts your ability to create and use derived works. The GPL
> > similarly does not permit such restrictions.
>
> That it does not, and such a restriction would violate the GPL, I'd
> agree to that.

	Okay.

> > You only have that right (in the United States) if the GPL_ONLY stuff is
> > *not* a copyright enforcement scheme.

> How can it be that? It does not restrict copying nor distribution
> nor modification.

	Copyright enforcement schemes can also restrict usage. Access cards for
satellite TV are purely usage restriction devices.

> People here are saying that it's more of a hint to people that they
> better think hard and ask a lawyer before implementing non-GPL'ed
> kernel modules.

	I'd agree with that.

> I think you bringing the DMCA into this shows an interesting aspect
> of that law: who gets to say what is a copyright enforcement scheme
> and what is not?

	The law has a somewhat incomprehensible definition of what consitutes such
a scheme. I don't think anybody really knows what things would be considered
copyright enforcement schemes and what would not.

	Your argument that the GPL does not grant usage rights is troubling. If
it's correct, then I have no right to use the Linux kernel, since the
copyright holders never granted it to me!

	DS


