Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTIMJt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbTIMJt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:49:28 -0400
Received: from mail.webmaster.com ([216.152.64.131]:25852 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262106AbTIMJtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:49:25 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Nicolas Mailhot" <Nicolas.Mailhot@laPoste.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: People, not GPL  [was: Re: Driver Model]
Date: Sat, 13 Sep 2003 02:49:22 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEDKGIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1063444117.7962.19.camel@rousalka.dyndns.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" wrote :

> [ sorry to interupt your flamewar but the amount of nonsence produced
> here  starts to irritate me ]

> | Who is sending these letters? Who has no respect for the GPL and seeks
> | to add additional restrictions?

> This is no additional restriction.
> Check your history. The linux kernel was always under the GPL, not the
> LGPL ie distributing stuff that links with the kernel means this stuff
> must be distributed under the gpl.

	Yes, *distributing* stuff that links with the kernel means this stuff must
be distributed under the GPL. Note that this is a restriction that only
kicks in when you distribute something. It places no restrictions on how you
can use derived works you don't distribute.

> At some point Linus decreeted linking closed modules was ok with him
> (note this was done without consulting anyone, so others contributors
> could have objected - they did choose to release stuff under the gpl
> after all - but this being Linus they let it pass)

	Right.

> At a later point however the scope of closed linking had grown so big
> people started saying enough is enough and GPL-ONLY was born with
> Linus's approval.

	Okay.

> It is not a licensing change. It's an hint the associated kernel symbols
> are not covered by Linus' previous informal exemption and full GPL rules
> apply.

	Fine, so long as it's not a license enforcement mechanism.

> To avoid rewriting history symbols that could be used in non-free
> stuff previously are not GPL-ONLY. People that ignore the hint can and
> will be sued (people that link to symbols not GPL-ONLY could be sued too
> but everyone seems to have agreed to let it pass).

	Sued for what? Violating a restriction that isn't part of the license?
That's no more illegal than removing the security checks on 'mount'.

> Removing the software
> GPL-ONLY checks or working around them has nothing to do with it - it
> does not change the basic kernel license nor the stated intentions of
> its authors to enforce it. Hiding a do-not-trespass sign does not give
> you the right to do it (if you think so do a reality check).

	Except that the GPL does not permit any usage restrictions.

> So please stop making horrified noises the GPL is being enforced in a
> GPL project. Don't you realise how ridiculous it is ?

	All of the GPL's restrictions kick in upon distribution. The GPL_ONLY
restrictions affect use even in the absence of distribution. Thus, the
GPL_ONLY stuff *cannot* be a license enforcement because what it enforces is
*not* part of the license. Anyone who distributed Linux claiming that it had
such a license restriction would be in violation of the GPL's prohibition
against distribution with additional restrictions. Can you please reply to
that specific argument?

	And this is not some whacko obsure legalistic argument. This is a
fundamental point. Many people who contributed to the Linux kernel
contributed *because* they believed in the GPL and felt assured that nobody,
not even Linus, could close the evolving works by putting usage restrictions
on it. You GPL a work because you want to keep not only the current code
open to unrestricted use but all future distributed derived works as well.
Nobody has the right to add new license restrictions beyond those present in
the GPL.

	DS


