Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUJJVzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUJJVzo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 17:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUJJVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 17:55:44 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:17421 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S268511AbUJJVzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 17:55:41 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Sam Hocevar" <sam@zoy.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: possible GPL violation by Free
Date: Sun, 10 Oct 2004 14:55:36 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEFAOOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44.0410101246000.28406-100000@chimarrao.boston.redhat.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 10 Oct 2004 14:32:20 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 10 Oct 2004 14:32:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, 10 Oct 2004, Sam Hocevar wrote:

> > > This leaves Free with 2 options:

> >    I know the GPL and I know they don't appear to be doing any of these
> > two things. However it might be hidden in some obscure agreement between
> > Free and the user, renounced upon in such an agreement (which would
> > violate the GPL, like QuakeLives did) or indeed not be there at all. And
> > the only people who can verify this are the Freebox users.

> Even if the Freebox users were to renounce their own
> rights under the GPL, I do not see how they could
> renounce OUR rights for us ...

	The GPL doesn't give any rights to anyone but the people the software is
distributed to. Though the agreement must be enforceable by any third party,
that third party must actually be a recipient of the agreement, either
directly or indirectly.

	So in other words, if you make a custom binary of the Linux kernel and
distribute it to me, then you have to give me an agreement that any third
party can enforce to get the source code. But I don't have to give that
agreement to any third parties if I don't want to.

	The rationale behind this requirement in the GPL is that without it,
redistribution would be difficult. Since the GPL allows the recipients of
the code to further distribute it, they must be also able to distribute the
right to the source code.

	The GPL does not permit you to impose any other restrictions. So you can't
use this as a loophole to escape the requirement of distributing the source
code. A simple way to understand it is this -- wherever the executable can
go, so too must the source go. Wherever the executable can go, so too must
the right to redistribute the executable (and therefore, so to must go the
ability to get the source).

	If you lawfully obtained the executable to anything derived from GPL'd
code, you should be able to obtain the source code. If not, you might or
might not be able to. If you have the executable, and didn't steal it or
something, you should also have either the source code or the right to
easily obtain the source code.

	DS


