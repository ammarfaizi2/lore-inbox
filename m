Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270075AbRIESqP>; Wed, 5 Sep 2001 14:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271740AbRIESqG>; Wed, 5 Sep 2001 14:46:06 -0400
Received: from mail.webmaster.com ([216.152.64.131]:28340 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S270075AbRIESpw>; Wed, 5 Sep 2001 14:45:52 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alan Shutko" <ats@acm.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.9-ac6
Date: Wed, 5 Sep 2001 11:46:11 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMMEFEDLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <87zo8atcvz.fsf@wesley.springies.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" <davids@webmaster.com> writes:

> > Yes, but even if the module is GPL'd, the module could still cost
> > $1,000 and you're not entitled to the source if you didn't buy the
> > module.

> OTOH, if you're getting a bug report from someone who has a GPLed
> module, they can get the source and send it to you.

	Perhaps, but:

	1) They may not have it or know the procedure to get it.

	2) The offer for the source may have expired.

	3) This is true whether or not the module is GPLed, they may have the
source or they may not.

	4) Many other licenses may result in publically available source and may
not, just like the GPL.

	If you want to make sure the user has the source from which the module was
built, that can be checked for. (Though it's not simple, unfortunately.)

	What you want to do is make sure the user understands that he had better be
able to produce the source for any kernel modules loaded at the time of the
problem. If not, he needs to reproduce the bug on a system without the
relevant modules.

	I think a tag for 'source code is available to anyone for debugging
purposes, no questions asked' is more what's wanted.

	DS

