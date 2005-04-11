Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVDKCk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVDKCk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 22:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDKCk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 22:40:57 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:34052 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261667AbVDKCkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 22:40:36 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>, <debian-legal@lists.debian.org>
Subject: RE: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Sun, 10 Apr 2005 19:40:27 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEABDBAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <8764yurwef.fsf@kreon.lan.henning.makholm.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 10 Apr 2005 19:39:39 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 10 Apr 2005 19:39:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The GPL applies to distributing a Linux binary I just made even
> > though nobody ever chose to apply the GPL to the binary I just made
> > only because the binary I just made is a derivative work of the
> > Linux kernel, and the authors of that work chose to apply the GPL to
> > it.

> How can the binary be a derivative work when it does *not* contain
> firmware, but suddenly cease to be a derivative work if one *does*
> add firmware into it?

	Because, the argument would go, the binary with the firmware linked in is
not a work, it is two works that are aggregated because there's a license
boundary between them. The argument would be that the binary with the
firmware is *a* *derivative* *work* of the Linux kernel source. The "a" is a
critical part of the argument that cannot be omitted. Showing that the
linked binary was two works would be sufficient to significantly weaken the
argument that it can't be distributed.

	You can't argue that only the GPL gives you the right to distribute the
result, regardless of what it is, because there are other sources of such
rights. These include fair use, first sale, and the fact that the law does
not create a special right to restrict the distribution of lawfully-created
derivative works (to licensees of the original work).

	My point is not simply that the question of whether or not linking creates
a single work that is a derivative work of all the things linked is
important to the question of whether you can distribute GPL'd works linked
with non-GPL'd works. And the standard is copyright law, not what the GPL
says. (Though that's also important, because then you would have even more
rights.)

	DS


