Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965411AbWH2VU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965411AbWH2VU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965416AbWH2VU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:20:28 -0400
Received: from mail.linicks.net ([217.204.244.146]:61195 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S965411AbWH2VU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:20:27 -0400
From: Nick Warne <nick@linicks.net>
To: "Patrick J. Volkerding" <volkerdi@slackware.com>
Subject: Re: Linux 2.4.33.2
Date: Tue, 29 Aug 2006 22:19:59 +0100
User-Agent: KMail/1.9.4
Cc: Petri Kaukasoina <kaukasoina603mxtg1n@sci.fi>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       wtarreau@hera.kernel.org, gcoady.lk@gmail.com, mtosatti@redhat.com
References: <200608271235.k7RCZlru005427@harpo.it.uu.se> <200608271731.36674.nick@linicks.net> <44F4AD1F.7010707@slackware.com>
In-Reply-To: <44F4AD1F.7010707@slackware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608292219.59949.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 22:09, Patrick J. Volkerding wrote:
> Nick Warne wrote:
> > On Sunday 27 August 2006 17:28, Petri Kaukasoina wrote:
> >> On Sun, Aug 27, 2006 at 03:50:29PM +0100, Nick Warne wrote:
> >>> Good question - all I can find is the slackware package
> >>
> >> I guess this is what you are looking for:
> >>
> >> ftp://ftp.slackware.com/pub/slackware/slackware-current/source/l/glibc/g
> >>lib c.kernelversion.diff.gz
> >
> > Good god - what a mess...
>
> I agree, even though I'm not sure if you mean the original .h algorithm,
> my fix, or glibc's system of reducing a Linux kernel version to a single
> integer for easy comparison, though.
>
> I'm glad my hack is getting some review.  It's of the "ugly but probably
> reliable" variety.  More so than if I'd tried to fix the loop below
> it...  I felt it much safer to just fix the input string to give it
> those "at most three parts" that it was designed for.

My 'my god' bit was to glibc - not the fix!  I bow down to you guys, seeing 
what you had to do to suss it and get to work...

Where on earth did the assumption of 'three dots' come from anyway?

Nick
-- 
Every program has two purposes:
one for which it was written and another for which it wasn't.
