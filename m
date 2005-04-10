Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVDJDHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVDJDHZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 23:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDJDHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 23:07:25 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:53252 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261288AbVDJDHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 23:07:17 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>, <debian-legal@lists.debian.org>
Subject: RE: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Sat, 9 Apr 2005 20:07:03 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEELGDAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <874qegkxjp.fsf@kreon.lan.henning.makholm.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 09 Apr 2005 20:06:14 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 09 Apr 2005 20:06:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Scripsit "David Schwartz" <davids@webmaster.com>

> >> I think the "derivative work" angle is a red herring. I do not think
> >> that either of the two parts that are being linked together (i.e. the
> >> driver and the firmware) are derivates of the other.  The relevant
> >> point is that distribution of the linked _result_ is nevertheless
> >> subject to the condition in GPL #2, which is in general the only
> >> source we have for a permission to distribute a non-verbatim-source
> >> form of the driver.

> > 	If the thing distributed is not the covered work and not a
> > derivative work, why does the GPL apply to it at all?

> You are free to not apply the GPL to it.

> However, then you cannot legally copy it at all, because it contains
> part of the original author's copyrighted work and therefore can only
> legally be copied with the permission of the author.

	The way you stop someone from distributing part of your work is by arguing
that the work they are distributing is a derivative work of your work and
they had no right to *make* it in the first place. See, for example, Mulcahy
v. Cheetah Learning.

	My point is that the reason the derivative work issue is so important is
because it's the only way (in U.S. law anyway) that the GPL can apply to
anything other than the exact thing the author chose to apply it to. The GPL
applies to distributing a Linux binary I just made even though nobody ever
chose to apply the GPL to the binary I just made only because the binary I
just made is a derivative work of the Linux kernel, and the authors of that
work chose to apply the GPL to it.

	DS


