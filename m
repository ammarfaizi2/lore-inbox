Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263024AbTCLE2v>; Tue, 11 Mar 2003 23:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263027AbTCLE2v>; Tue, 11 Mar 2003 23:28:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263024AbTCLE2u>; Tue, 11 Mar 2003 23:28:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Date: 11 Mar 2003 20:39:19 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4mdln$cd$1@cesium.transmeta.com>
References: <20030312034330.GA9324@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030312034330.GA9324@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
> 
> If all of this sounds nice, it is.  It was a lot of work for us to do
> this and you might be wondering why we bothered.  Well, for a couple of
> reasons.  First of all, it was only recently that I realized that because
> BK is not free software some people won't run BK to get data out of BK.
> It may be dense on my part, but I simply did not anticipate that people
> would be that extreme, it never occurred to me.  We did a ton of work to
> make sure anyone could get their data out of BK but you do have to run
> BK to get the data.  I never thought of people not being willing to run
> BK to get at the data.  Second, we have maintained SCCS compatible file
> formats so that there would be another way to get the data out of BK.
> This has held us back in terms of functionality and performance.  I had
> thought there was some value in the SCCS format but recent discussions
> on this list have convinced me that without the changeset information
> the file format doesn't have much value.
> 

I can only speak for myself, but I didn't mind until the license ended
up having the "unless you hack on other tools" exception in it.
Personally, I value my freedom to hack on whatever I want a lot more
than the convenience of BK.  This is a personal choice on my part and
may sound "extreme" to you, and other people have made other
tradeoffs, but for me freedom was the reason I started hacking Linux
instead of becoming a Win32 geek.

Having this capability available will certainly make life better for
everyone involved.  Besides, "we won't hold your data hostage" is
actually a pretty nice selling argument.

> 
> Our goal is to provide the data in a way that you can get at it without
> being dependent on us or BK in any way.  As soon as we have this
> debugged, I'd like to move the CVS repositories to kernel.org (if I can
> get HPA to agree) and then you'll have the revision history and can live
> without the fear of the "don't piss Larry off license".  Quite frankly,
> we don't like the current situation any better than many of you, so if
> this addresses your concerns that will take some pressure off of us.
> 

I'm sure we can work something out.  However, at the moment
zeus.kernel.org, our main server with lots and lots of bandwidth, is
starting to run into its limits, so I can't promise *when* that will
happen.  Just putting in another server 

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
