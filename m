Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWI2HTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWI2HTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 03:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWI2HTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 03:19:17 -0400
Received: from mail1.webmaster.com ([216.152.64.169]:35593 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1030385AbWI2HTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 03:19:16 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPLv3 Position Statement
Date: Fri, 29 Sep 2006 00:18:56 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEOLOLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.61.0609290757400.30682@yvahk01.tjqt.qr>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 29 Sep 2006 00:21:42 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 29 Sep 2006 00:21:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So what would happen if I add an essential GPL2-only file to a "GPL2
> or later" project?

The files would have to act as a license boundary. Otherwise, it would be
GPL2 only. (However, I think people could reasonably assume that if someone
contributed to a GPL2 or later project, they intended their work to be
licensed the same as the project.)

> Let's recall, a proprietary program that
> combines/derives with GPL code makes the final binary GPL (and hence
> the source, etc. and whatnot, don't stretch it). Question: The Linux
> kernel does have GPL2 and GPL2+later combined, what does this make
> the final binary?

GPL2. If you combine dual licensed code with GPLv2 code, the result must be
GPLv2.

> (Maybe you implicitly answered it by this already, please indicate):
> >Exactly. The GPLv3 can _only_ take over a GPLv2 project if the
> "or later"
> >exists.
> From that I'd say it remains GPL2 only.

I still don't see how it can take over, unless the FSF fixes the "bug" in
GPLv3. GPLv2 does not permit such takeover, and unless GPLv3 is amended to
do so, such a takeover is prohibited.

I could be in error, I haven't looked closely enough. But if I'm right, I
presume the FSF will be tipped off by someone and fix it. If anyone from the
FSF is listening, you need to add a clause to GPLv3 permitting you to modify
any project licensed under both the GPLv3 and another license such non-GPL
and/or earlier-GPL licenses can be removed. Otherwise, no 'GPLv2 or later'
project can become 'GPLv3 or later'. (Unless that's intentional.)

DS


