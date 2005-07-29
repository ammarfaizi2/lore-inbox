Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVG2PTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVG2PTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVG2PQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:16:53 -0400
Received: from pop.gmx.de ([213.165.64.20]:27798 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262618AbVG2POs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:14:48 -0400
Date: Fri, 29 Jul 2005 17:14:44 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Nix <nix@esperi.org.uk>
Cc: mingo@elte.hu, mpm@selenic.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, akpm@osdl.org, chrisw@osdl.org
MIME-Version: 1.0
References: <87u0idhdju.fsf@amaterasu.srvr.nix>
Subject: =?ISO-8859-1?Q?Re:_Broke_nice_range_for_RLIMIT_NICE?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <12213.1122650084@www71.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 29 Jul 2005, Michael Kerrisk stated:
> > Yes, as noted in my earlier message -- at the moment RLIMIT_NICE 
> > still isn't in the current glibc snapshot...
> 
> According to traffic on libc-hacker, Ulrich committed it on Jun 20
> (along with RLIMIT_RTPRIO support).

I (now) see the message that you mean on libc-hacker, nevertheless,
looking at the glibc-2.3-20050725 snapshot, these two constants do 
not appear anywhere.  (Strange!)

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
