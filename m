Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUJaAVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUJaAVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUJaAVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:21:23 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:1805 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261440AbUJaAVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:21:20 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Larry McVoy" <lm@bitmover.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: BK kernel workflow
Date: Sat, 30 Oct 2004 17:20:17 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEOOPGAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20041030233532.GA24640@work.bitmover.com>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 30 Oct 2004 16:56:52 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 30 Oct 2004 16:56:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Indeed.  Kyle's comments were clearly without basis in fact.  Saying
> that you aren't bound by the terms of the license because you didn't
> download the code, your co-worker did, is no different than saying "hey,
> look at this!  A copy of the Linux kernel!  Now how did that get here?
> Well, I didn't put it here so I think I'll ignore the terms of the GPL."
> Best of luck on that logic.

	No, these are in no way comparable. The big difference between copyright
and contract is that I don't have to agree to give you copyright rights.
Your analogy blurs this *major* distinction. The problem with having a
co-worker agree to the license is it's not clear how you would get the right
(under copyright) to use the software.

	The big questions, IMO, are:

	1) Will courts really uphold click-wrap agreements in contradiction to
first sale, and

	2) Will courts really uphold the DMCA in defense of rights obtained by
contract, not copyright.

	My opinion is this:

	Yes on the first question. They will. Largely because they 'first sale'
only seems to apply when you own something, and if software is leased or
licensed to you, you don't own anything. I think this is a bad
interpretation of copyright law, but I think courts will run with this. This
effectively guts all rights to fair use or first sale for at least computer
software. If someone can say "you must yield your fair use rights to obtain
any right to use this software", then there effectively is no right to fair
use at all. (One wonders if you can do the same thing with books and CDs.)

	No on the second question. The current case that suggests this is, I hope,
an aberration. The DMCA is a very powerful right that should be subject to
the same restrictions other Federal copyright rights are subject to. It
should not be expanded to defend rights obtained by contract and not
recognized under contract law.

	I want to take one minute to thank Larry for the efforts he has put forward
to help the Linux kernel project and, specifically, for the effort has has
put to make Linus' life easier and more productive. We all benefit from
this. Yes, Larry benefits too, but many kernel developers also benefit from
the work they do. It would be a strange twist if we expected people to work
on GPL'd projects to their personal detriment.

	DS


