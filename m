Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTKIPQg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 10:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTKIPQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 10:16:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262274AbTKIPQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 10:16:33 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.bkbits.net off the air
Date: 9 Nov 2003 07:16:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bollnv$uvt$1@cesium.transmeta.com>
References: <20031107051048.GA6099@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031107051048.GA6099@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
>
> As many of you have figured out, I took kernel.bkbits.net (aka bk.kernel.org,
> cvs.kernel.org, and svn.kernel.org) of the air yesterday due to the breakin
> that attempted to add a trojan horse to the kernel source.
> 
> I took it down after talking with Linus and Dave about it, the point was to
> shut down the disk drive so that we can go do forensics on it after the fact
> and see what we can figure out.  Maybe someone can track down who caused the
> problem.
> 
> This means someone has to go down to the colo with a new disk and do
> an install and we've been too busy to do this.  Would anyone object if
> this wasn't done until this weekend?  We're pretty booked up here with
> other work.  Last I checked only about 6 IP addresses where using the CVS
> server, I've never checked on the SVN server (Ben?  You have any idea?).
> 

That doesn't include anyone who uses the mirrored repository on the
main kernel.org machines.  Doubt it's a big deal with the timing,
though.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
