Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTLJAQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTLJAQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:16:05 -0500
Received: from gprs145-126.eurotel.cz ([160.218.145.126]:40578 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262707AbTLJAQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:16:01 -0500
Date: Wed, 10 Dec 2003 01:16:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Maitin-Shepard <jbms@attbi.com>
Cc: linux-kernel@vger.kernel.org, Kendrick Hamilton <hamilton@sedsystems.ca>
Subject: Re: Linux Kernel and GPL section 2c
Message-ID: <20031210001652.GC618@elf.ucw.cz>
References: <3FD4BF6E.7070503@sedsystems.ca> <87ptezgnfv.fsf@jay.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ptezgnfv.fsf@jay.local.invalid>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hello all,
> >     I noticed the discussion about linux kernel modules that happened last
> >     week. I was wondering about something with regards to the linux kernel and
> >     Section 2c of the GPL. Why doesn't the kernel on booting print something
> >     about the kernel being free software licensed under the GPL, and shouldn't
> >     it?
> 
> Presumably, 1) the kernel as a whole is not a "modified" work, but
> rather at least parts of it are the original work, 2) it does not read
> commands interactively when run, 3) it does not normally print such
> announcements.

I see such announcements. I think we should just kill them all:

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
CSLIP: code copyright 1989 Regents of the University of California.
Linux agpgart interface v0.100 (c) Dave Jones
ip_tables: (C) 2000-2002 Netfilter core team

Or perhaps we can replace 'POSIX conformance testing by UNIFIX' with
'Distribute under GPLv2'?
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
