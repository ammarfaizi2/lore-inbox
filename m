Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUKFDac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUKFDac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUKFD3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:29:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4356 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261307AbUKFD0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:26:16 -0500
Subject: RE: Possible GPL infringement in Broadcom-based routers
From: David Woodhouse <dwmw2@infradead.org>
To: davids@webmaster.com
Cc: "Jp@Enix. Org" <jp@enix.org>, linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOECKPJAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKOECKPJAA.davids@webmaster.com>
Content-Type: text/plain
Date: Sat, 06 Nov 2004 03:23:24 +0000
Message-Id: <1099711404.27598.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 11:59 -0800, David Schwartz wrote:
> If that were true, I could poem up on a billboard and sue anyone who read it.

Your analogy is flawed. Consider instead the case where you want to sue
not someone who _read_ it, but someone who copied it down into their
notebook, went home and then published an anthology of poems including
yours. 

>  The FSF is, of course, free to take any position it wants to. As I
> understand the law, if you want to restrict use, you must restrict access.
> Give free access, you give free use.

Adam said 'an activity that is restricted by copyright', and in the
context it's blindingly obvious that he means _copying_ and
_distribution_, not just use. Yet you persist in your misdirection.

Anyone copying and distributing the Linux kernel must comply with the
copyright licence which _conditionally_ grants them permission to do so.

In particular, the permissions granted by the GPL on the Linux kernel
are conditional on your agreement that when you distribute a collective
work which is based in part on the Linux kernel, you also release all
other parts of that whole, EVEN THOSE WHICH ARE NOT DERIVED WORKS OF THE
KERNEL, under the terms of the GPL.

The GPL does not claim any fundamental 'rights' to those parts which are
your own work, just as commercial copyright licences don't claim any
fundamental 'right' to your money. It's just a trade you are offered;
that is what is asked of you, in return for permission to distribute the
GPL'd work.

You have the right to refrain from entering that agreement; to refrain
from distributing the GPL'd work. You do not have the right to
distribute the GPL'd work _without_ complying with the terms of its
licence. That would be a criminal offence.

Anyone distributing a work which is a whole based on the Linux kernel
and other non-GPL'd works, other than 'mere aggregation on a volume of a
storage or distribution medium', is quite clearly violating the terms of
the GPL. (Bearing in mind the specific exception for userspace).

It's very clear, given that the firmware for these routers is completely
useless without either the kernel or the network driver modules, that
it's more than 'mere aggregation' -- the parts form a coherent whole.

Thus, even when the modules are NOT a 'derived work', they _MUST_ be
distributed under the terms of the GPL in order for permission to
distribute the _kernel_ to be granted.

-- 
dwmw2

