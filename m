Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbUKFUJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUKFUJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUKFUJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 15:09:48 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:33799 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261459AbUKFUJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 15:09:44 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Jp@Enix. Org" <jp@enix.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Possible GPL infringement in Broadcom-based routers
Date: Sat, 6 Nov 2004 12:09:42 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEIEPJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <1099711404.27598.44.camel@localhost.localdomain>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 06 Nov 2004 11:46:11 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 06 Nov 2004 11:46:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	This is exactly the argument I hoped would *not* arise on the LKML. I'll
try not to reply further unelss someone posts something fundmanetally new.

> Anyone copying and distributing the Linux kernel must comply with the
> copyright licence which _conditionally_ grants them permission to do so.

	*sigh* We're not talking about anyone copying or distributing *the* Linux
kernel. We're talking about someone copying or distributing another work
that is derivative of the Linux kernel (which is also *a* Linux kernel, just
not *the* Linux kernel). This is true whether they distribute the module
separately or linked with the Linux kernel. In either case, they are not
distributing the actual work placed under the GPL but a distinct, yet
derivative, work.

	The GPL can only conditionally grant permission to distribute a derivative
work if that is a right normally reserved to the author of a work. Yet
nobody has yet presented any law that reserves to a copyright holder the
right to restrict the distribution of derivative works.

> In particular, the permissions granted by the GPL on the Linux kernel
> are conditional on your agreement that when you distribute a collective
> work which is based in part on the Linux kernel, you also release all
> other parts of that whole, EVEN THOSE WHICH ARE NOT DERIVED WORKS OF THE
> KERNEL, under the terms of the GPL.

	This is the GPL trying to set the scope of its own authority. Nothing in
the GPL matters unless you try to do something that you could only get the
right to do from the GPL itself. Otherwise, you are free to refuse to accept
the GPL.

> The GPL does not claim any fundamental 'rights' to those parts which are
> your own work, just as commercial copyright licences don't claim any
> fundamental 'right' to your money. It's just a trade you are offered;
> that is what is asked of you, in return for permission to distribute the
> GPL'd work.

	Except you're not distributing the GPL'd work! You are totally putting the
cart before the horse here. You are assuming that the compiled object that
they are distributing is a GPL'd work to show that it must be covered by the
GPL because it's distributed.

> You have the right to refrain from entering that agreement; to refrain
> from distributing the GPL'd work. You do not have the right to
> distribute the GPL'd work _without_ complying with the terms of its
> licence. That would be a criminal offence.

	Here again you put the cart before the horse. You say that I'm
"distributing the GPL'd work". Why is it GPL'd? Because the GPL says it
covers collective works. But since I refused the GPL, why does it matter
what the GPL says?!

> Anyone distributing a work which is a whole based on the Linux kernel
> and other non-GPL'd works, other than 'mere aggregation on a volume of a
> storage or distribution medium', is quite clearly violating the terms of
> the GPL. (Bearing in mind the specific exception for userspace).

	Again, you are quoting the GPL to decide the scope of its own authority in
the case where a person refuses to accept the GPL.

> It's very clear, given that the firmware for these routers is completely
> useless without either the kernel or the network driver modules, that
> it's more than 'mere aggregation' -- the parts form a coherent whole.

	It is quite useful without *the* kernel. It is quite useful as a single
work, *a* kernel but not *the* kernel. A distinct (yet derivative) work.

> Thus, even when the modules are NOT a 'derived work', they _MUST_ be
> distributed under the terms of the GPL in order for permission to
> distribute the _kernel_ to be granted.

	For the love of god, you're not distributing *the* kernel, you're
distributing *a* kernel. A distinct work, albeit a derivative work. How hard
is that to understand?

	DS


