Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbUKJFIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUKJFIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 00:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUKJFIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 00:08:13 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:60932 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261885AbUKJFID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 00:08:03 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mdpoole@troilus.org>, "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: GPL Violation of 'sveasoft' with GPL Linux Kernel/Busybox +code
Date: Tue, 9 Nov 2004 21:07:18 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEOMPKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <87actqfigw.fsf@sanosuke.troilus.org>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 09 Nov 2004 20:43:48 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 09 Nov 2004 20:43:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > You can fully exercise your rights under the GPL; they are not
> > > restricted.  However, you cannot expect future support from Sveasoft.
> > But if I paid $20 for one year of said support?

> The contract might have a termination clause triggered if you do a
> handstand or file a patent lawsuit against Sveasoft.  By your
> argument, that would make the contract breach the GPL, since you could
> not use the GPLed software while doing those things -- which is
> ridiculous on its face.

	No, because they don't restrict your exercise of your rights under the GPL.
None of these things are predicated upon your exercise of your GPL rights,
so they don't restrict them.

	If not for the GPL's further restriction clause, SveaSoft could condition
their contracts with termination clauses based upon any set of rules they
want. However, due to the GPL's further restriction clause, they cannot
penalize people for exercising their rights under the GPL. This is the
specific intent of that clause in the GPL. It's intended to prevent people's
GPL rights from being encumbered by outside licenses and contracts.

> I suspect that an activation key would violate the GPL, but that is a
> different question than the support contract.

	Nope. The GPL is perfectly clear that you can modify GPL'd code to do
whatever you want. If you want to add code to require an activation key,
that is your right. If you want to distribute the resulting code, that is
your right too, assuming you comply with the GPL's other clauses. That check
on this is supposed to be that others could remove the activation key and
distribute the modified binaries and source.

	SveaSoft is trying a new trick now. They're essentially claiming that their
firmware is an aggregation of both GPL'd and proprietary works, and
therefore you can't distribute it unless you can separate the works somehow.
I think they are exploiting areas of the GPL that are slightly gray.
Clearly, reasonable people can disagree on what a "further restriction" is
or what a "mere aggregation" is.

	Anyway, this has long stopped being interesting to LKML folks.

	DS


