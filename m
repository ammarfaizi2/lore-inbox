Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbTINVk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 17:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTINVk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 17:40:59 -0400
Received: from mail.webmaster.com ([216.152.64.131]:13264 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261641AbTINVk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 17:40:56 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <andersen@codepoet.org>, "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: People, not GPL  [was: Re: Driver Model]
Date: Sun, 14 Sep 2003 14:40:51 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEKKGIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030914043716.GA19223@codepoet.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I invite you to read the COPYING file included in each and every
> kernel tarball.  There is exactly ONE exception granted in the
> linux kernel copyright:
>
>     This copyright does *not* cover user programs that use kernel
>     services by normal system calls - this is merely considered
>     normal use of the kernel, and does *not* fall under the
>     heading of "derived work".

	You are mistaken about what this is. This is not an exception being
granted. Nobody has the authority to grant GPL exceptions unless they are
the sole author and the Linux kernel does not have a sole author.

> All the noise in the world about other exceptions is precisely
> that, since the license granting use of the Linux kernel does
> not contain any additional provisions.

	This is not a license provision, it's a license interpretation. If you can
show me why the interpretation doesn't apply to kernel modules, please do.

> Anything that can be identified as a "user program" that "use[s]
> kernel services by normal system calls" is, by virtue of the above
> license grant, doing so with permission and is therefore within
> its rights.  So you can make all the closed source user space
> only One True(tm) iSCSI stacks you want.

	Except it's not a license grant. If it is a license grant, please tell me
who had the authority to grant it.

> Anything that is not a "user program" (and I think everyone can
> agree a kernel module is not a "user program") is therefore a
> derivitive work.

	Hahahahhahaha! Oh, that's too funny. "All dogs are mammals" means things
that aren't dogs aren't mammals? My pencil isn't a "user program". Is it a
derivative work of the Linux kernel in your opinion?

> Anything that is linked into the kernel (and I think everyone can
> agree a kernel module is linked into the kernel) and is therefore
> interfacing with kernel internals, rather than using "kernel
> services by normal system calls" is therefore a derivitive work.
>
> Laugh at people, mock people, rant, rave, wantever you want.
> When you are done making noise, please have your laywer explain
> how a closed source binary only product that runs within the
> context of the Linux kernel is not a derivitive work, per the
> very definition given in the kernel COPYING file that grants you
> your limited rights for copying, distribution and modification,

	The same way a user program that runs within the context of the Linux
operating system is not a derivative work. A defined interface creates a
license boundary. If you can draw a line between the two works, neither is
derivative of the other.

	And you are still ignoring the entire point, which is that it doesn't
matter whether or not such modules are derivative works. The GPL puts no
restrictions whatsoever on the creation or usage of derivative works that
are not distributed. The GPL does not say that you cannot make derivative
works unless you GPL them.

	So the restriction GPL_ONLY places is *not* a restriction that exists in
the GPL which is the *only* license. Hence it does not enforce a license
restriction. It really is that simple.

	And when it comes to respecting the author's wishes, I respect the wishes
of the many people who contributed to the Linux kernel expecting the GPL to
ensure that usage remained unrestricted. I don't not respect the wishes of
the people who try to impose usage restrictions on other people's GPL'd code
and I thoroughly disrespect those who would wield the DMCA to restrict
modifications to code placed under the GPL.

	DS


