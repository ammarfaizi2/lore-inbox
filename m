Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbTCHCP6>; Fri, 7 Mar 2003 21:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262008AbTCHCP6>; Fri, 7 Mar 2003 21:15:58 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:19463 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262003AbTCHCP5>; Fri, 7 Mar 2003 21:15:57 -0500
Date: Sat, 8 Mar 2003 03:26:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Lang <david.lang@digitalinsight.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303071753100.1933-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0303080315400.32518-100000@serv>
References: <Pine.LNX.4.44.0303071753100.1933-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Mar 2003, David Lang wrote:

> > There is still the possibility to support multiple libc implementation, if
> > you don't like dietlibc, you're still free to use klibc.
> 
> along the same lines if you don't like klibc you are free to use or
> implement dietlibc or anything else.

Using it and including it into the kernel source are still two different 
things. Why should we allow the precedent and create such a license mess?
The problem is easy to ignore now, but it will possibly hunt us forever.

> This was very much not intended to start a flamewar (and I do apologize if
> anyone was offended by the post), but I think the very real fear of
> oversealous GPL defenders is a large part of the reason why a modified GPL
> was not chosen.

This is simply not true, if the usage terms are clearly defined in 
advance, we can easily easily ignore the trolls. Did anyone ever complain 
about the libgcc license? I don't think your fear is justified.

bye, Roman


