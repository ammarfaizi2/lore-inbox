Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTIOF5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 01:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTIOF5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 01:57:25 -0400
Received: from codepoet.org ([166.70.99.138]:38373 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262449AbTIOF5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 01:57:19 -0400
Date: Sun, 14 Sep 2003 23:57:21 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20030915055721.GA6556@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <20030914064144.GA20689@codepoet.org> <Pine.LNX.4.10.10309140004430.16744-100000@master.linux-ide.org> <20030914080810.GA22137@codepoet.org> <bk30f1$ftu$2@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bk30f1$ftu$2@tangens.hometree.net>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 15, 2003 at 12:17:37AM +0000, Henning P. Schmiedehausen wrote:
> Erik Andersen <andersen@codepoet.org> writes:
> 
> >When you are done making noise, please explain how a closed
> >source binary only product that runs within the context of the
> >Linux kernel is not a derivitive work and therefore not subject
> >to the terms of the GPL, per the definition given in the kernel
> >COPYING file that grants you your limited rights for copying,
> >distribution and modification.
> 
> "Because Linus said so".

It does not say "Because Linus said so" in the Linux kernel
COPYING file, which is the only official document that grants
legal permission to copy, distribute and/or modify the kernel.

And even if Linus says so, what about Alan Cox, David S. Miller,
Al Viro, Andrea Arcangeli, Jens Axboe, Donald Becker, Andries
Brouwer, Jeff Garzik, Dave Jones, Russell King, Rik van Riel,
Rusty Russell, Ted Ts'o, Stephen Tweedie, etc, etc, etc?  What do
they say?  After all, the Linux kernel ceased to be a
one-man-show well over 10 years ago.  I know I have personally
submitted all my patches to the Linux kernel per the GPL, not
some imagined "GPL + kernel module exceptions" license.

If Linus wanted to say "I'm relicensing Linux under the Microsoft
EULA effective immediately", he is certainly entitled to
relicence the bits he personally wrote, but nothing more.
Similarly, if Linus wants to say the kernel allows binary only
kernel modules, he can certainly say as much -- free speech
entitles him to say whatever he wants.  But he has no authority
to relicense the bits of code I wrote, or the code anyone else
wrote, without their express permission.  I have never been asked
to agree to some other kernel license, and to my knowledge,
neither has anyone else.  Therefore the license as stated in the
kernel COPYING file is in effect.

To change the license for the entire kernel would require asking
every kernel contributor of substance to agree to new licensing
terms.  I'm sure some people (such as Andre) would be overjoyed
to have a "GPL + module exceptions" license made official.  And
as you might imagine, others would be rather less enthusiastic.
And still others, such as Leonard Zubkoff may find it difficult
to make posthumous licensing decisions.

But until such an official re-licensing effort is undertaken and
sucessfully completed, the Linux kernel is and will remain
licensed under the bog standard GPL with the one exception that
"user programs that use kernel services by normal system calls"
and not derivitive works -- i.e. the licensing terms specified
in the linux kernel COPYING file.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
