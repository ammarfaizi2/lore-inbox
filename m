Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVBIOsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVBIOsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBIOsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:48:37 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:49315 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261832AbVBIOr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:47:59 -0500
Date: Wed, 9 Feb 2005 15:48:01 +0100
From: "d.c" <aradorlinux@yahoo.es>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: lm@bitmover.com, stelian@popies.net, romieu@fr.zoreil.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-Id: <20050209154801.7578bcae.aradorlinux@yahoo.es>
In-Reply-To: <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
References: <20050204160631.GB26748@bitmover.com>
	<20050204170306.GB3467@crusoe.alcove-fr>
	<20050204183922.GC27707@bitmover.com>
	<20050204200507.GE5028@deep-space-9.dsnet>
	<20050204201157.GN27707@bitmover.com>
	<20050204214015.GF5028@deep-space-9.dsnet>
	<20050204233153.GA28731@electric-eye.fr.zoreil.com>
	<20050205193848.GH5028@deep-space-9.dsnet>
	<20050205233841.GA20875@bitmover.com>
	<20050208154343.GH3537@crusoe.alcove-fr>
	<20050208155845.GB14505@bitmover.com>
	<ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
X-Mailer: Sylpheed version 1.9.1+svn (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El 09 Feb 2005 05:06:02 -0200,
Alexandre Oliva <aoliva@redhat.com> escribió:

> So you've somehow managed to trick most kernel developers into
> granting you power over not only the BK history, in such a way that
> anyone willing to extract all the information available from the BK
> repository and share it with others is forbidden from doing so by the
> license?

BK history is not part of "linux kernel", and those who use BK know why they're
using BK and what are the consecuence so calling them "tricked" is quite
misleading from your part.


I don't understand people. Before BK, linux kernel development *never* had a
"history" and you had to develop against -pre patches. When linus switched
to BK, he said clearly that he wasn't going to change that, and it has not
changed, in fact these days you can use -bk patches which are much better
than -pre's. Then Larry put a CVS gateway just to made people happy and give
them things that have *NEVER* been guaranteed. So, "kernel history" is *not* part
of the "linux kernel development", is just a nice addon for those who optionally
want to use BK, because the _official_ way of getting changes for the linux
kernel are patches at kernel.org which don't have any way of keeping track of 
"kernel history", not BK and/or CVS. Everyone who claims the contrary is
wrong, period.

Besides, Larry is exporting most of that story in CVS, so those who accuse
Larry of "stealing our freedom" should think twice that Larry doesn't even
to _listen_ you and he doen't needs to care about your request because
it's not him who decided to use BK, and it's not him who decided to lose
the "kernel history" using a propietary tool. What you really want is change
the official kernel development (GNU diff patches at kernel.org) for something
better that can track all that "kernel history", and you are not going to change
that shouting at Larry because (again) it's *not* him who decided to use BK.

(of course if you ask linus he'll tell exactly what I said, that BK is just a _option_
and that you can get all the patches at kernel.org with all the consequences
- losing the "kernel history" because GNU diff don't really supports that)

