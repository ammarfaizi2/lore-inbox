Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbRGBPKk>; Mon, 2 Jul 2001 11:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbRGBPKa>; Mon, 2 Jul 2001 11:10:30 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:24680 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265310AbRGBPKL>; Mon, 2 Jul 2001 11:10:11 -0400
Date: Mon, 2 Jul 2001 10:09:44 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107021509.KAA52993@tomcat.admin.navo.hpc.mil>
To: jroland@roland.net, <jesse@cats-chateau.net>, <kmw@rowsw.com>,
        "J Sloan" <jjs@mirai.cx>
Subject: Re: Uncle Sam Wants YOU!
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Roland" <jroland@roland.net>:
> From: "Jesse Pollard" <jesse@cats-chateau.net>
> To: <kmw@rowsw.com>; "Kurt Maxwell Weber" <kmw@rowsw.com>; "J Sloan"
> <jjs@mirai.cx>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Sunday, July 01, 2001 3:03 PM
> Subject: Re: Uncle Sam Wants YOU!
> 
> 
> [snip]
> > >In that case, I have the following options:
> > >1) Start my own ISP
> >
> > Only if the upstream provider doesn't require you to use windows.
> >
> > >2) Use Windows XP
> > >3) Not use Windows XP and not be able to use my current ISP
> > >4) Go to a different ISP
> >
> > You may not be able to find another. It took me a year. I gave up. I was
> > fortunate that Verio doesn't care what you have... though if you use
> > the dialup or basic dsl, MS is it, or no real support.
> >
> > >I'll just have to decide which I value more.  As long as I won't be
> killed
> > >for using a different OS, I still have a choice.
> >
> > No, but you might be forced out of a job.
> 
> In one of the large metro areas in which I live, there are a LOT of ISPs
> that do not require you to use Windows, but will not support you beyond the
> IP layer if you don't.  Use linux, install PPP with MS-CHAPv2 (with or
> without MPPE) for your dialup connection and it works just fine on a
> Winblows-only ISP.  DSL or Cable, just acquire your actual IP settings
> program a Linksys router/hub box and be done with it.

Better re-read the fine print on the "fair-use" statement. BOTH DSL and
Cable, or dialup (New Orleans at least) will disconnect you if you run ANY
unattended operation (if they determine it IS unattended). No daemon services.
No routing/NAT (unless they do it). No remote login. No mail. DHCP reconfig
between 4 and 8 hours (or whenever they choose to).

They will let you plug in, but will not provide any support (even TCP/IP is
not assured).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
