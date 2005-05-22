Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVEVUzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVEVUzP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 16:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVEVUzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 16:55:15 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:4775 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261724AbVEVUzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 16:55:02 -0400
Message-Id: <4290F1B9.6040102@khandalf.com>
Date: Sun, 22 May 2005 22:55:21 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi
    SuperIO chip
References: <200505220008.j4M08uE9025378@hera.kernel.org>
    <1116763033.19183.14.camel@localhost.localdomain>
    <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org>
    <1116785646.6285.24.camel@laptopd505.fenrus.org>
    <20050522194438.A9854@flint.arm.linux.org.uk>
    <1116787877.6285.26.camel@laptopd505.fenrus.org>
    <20050522200344.B9854@flint.arm.linux.org.uk>
    <Pine.LNX.4.58.0505221324300.2307@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505221324300.2307@ppc970.osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Md5-Body: 311cbf5f7abf045d0e6a69ae7af082b8
X-Transmit-Date: Sunday, 22 May 2005 22:55:43 +0200
X-Message-Uid: 0000b49cec9d690500000002000000004290f1cf0001f8bb00000001000a3a07
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-06.tornado.cablecom.ch 32701; Body=4
	Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see below.

Linus Torvalds wrote:
> 
> On Sun, 22 May 2005, Russell King wrote:
> 
>>Therefore, I put forward that this thing which appears to be called
>>"author" does not reflect authorship, but who submitted it.
> 
> 
> It _is_ supposed to reflect authorship, but it does so within the context 
> of the SCM, not in any other larger context. In git, "author:" is a fairly 
> descriptive TAG, nothing more.
> 
> Don't get hung up about technicalities. If the field said
> 
> 	frog: Arjan van de Ven <arjan@infradead.org>
> 
> that wouldn't mean that Arjan would have been magically transformed into a
> frog in the real world sense, would it?
> 
> The fact that the field says "author:" does not mean that the person named
> is necessarily the "author" in the _copyright_ sense, it only means that
> he is the author in the limited sense that "git" gives it. And in the 
> limited "git" sense, it's really an educated guess, aka "we're tryign to 
> give credit where credit is due".

There is an argument, after SCO, for a

copyright: xxx

tag, and a clear public statement on the kernel.org home page about
assignment, the GPL and submission.

> 
> The fact is, trying to be technical about single words in human language
> and thinking that that a meaning in one specific context carries over to
> some other usage of a word in another context is simply not true. Not 
> here, not _anywhere_. 
> 
> And btw, lawyers and judges aren't idiots either. They're human beings, 
> and they can tell the difference between two contexts. Trying to argue 
> some silly technicality with a judge is not likely to get you very far in 
> general.

Absolutely right, and outside the US, the Costs in Cause, principle
means that any attempt at vexatious litigation is likely to prove an
expensive mistake.

-- 
mit freundlichen Grüßen, Brian.


