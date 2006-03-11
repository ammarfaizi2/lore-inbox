Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWCKLnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWCKLnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 06:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWCKLnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 06:43:43 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:8975 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750917AbWCKLnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 06:43:42 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Sat, 11 Mar 2006 03:43:31 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEHBKKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060311091623.GB4087@DervishD>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 11 Mar 2006 03:39:56 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 11 Mar 2006 03:40:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     No, it's not on the same level. It's on the same level as giving
> your thesis draft to a comrade so he can study and pass his exams,
> and in turn he publish the thesis as his and charge money for that.

	Except it's not. We're not talking about people taking the Linux kernel and
then publishing and charging for the Linux kernel. If we were, your analogy
would be correct.

	What you're talking about is more like you giving your thesis draft to a
comrade so that he can study and pass his exams and then claiming that you
own his exams. Or that you own his criticisms to your draft.

>     I don't want my work used by a corporation without giving any
> modification under the same conditions under I published my work.
> Binary driver can and will do harm if allowed.

	If you want to restrict *use* you need an EULA, shrink wrap agreement,
click-through or signed contract. If you give away copies of your work with
no conditions on the *receipt* of the work, you lose the right to control
how the work is used. Otherwise, someone could drop a million copies of
their poem from an airplane and then sue everyone who read it.

	Copyright is simply not powerful enough to allow you to control *any*
practical way to do a particular thing (say, make an NE2000 card work with
Linux 2.6). It is only powerful enough to allow you to control the one
specific way that *you* chose to do something. If you want software patents,
you know where to find them.

	You cannot use copyright to own *every* way to express a particular idea.
You cannot even use it to own every practical way to express a particular
idea. Is is quite clear that "use a different operating system" or "use
hardware for which there are already drivers in the kernel" are simply other
ideas, not other ways to express the same idea.

	I advise everyone with an interest to read carefully the entire decision in
Lexmark v. Static Controls. It clearly talks about how once you own every
practical way to do a particular thing, you cease to be allowed to use
copyright to do it. (Lexmark had a copyrighted Toner Loading Program in
their print cartridges which Static Controls 'stole' to make compatible
print cartridges. The court held that, among other things, even though the
TLP would otherwise have been copyrightable, since it was the only practical
way to make a cartridge work with certain Lexmark printers, copyright was
not applicable.)

	DS


