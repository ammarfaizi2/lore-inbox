Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262071AbSIYTSN>; Wed, 25 Sep 2002 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262072AbSIYTSN>; Wed, 25 Sep 2002 15:18:13 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:37769 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262071AbSIYTSL>; Wed, 25 Sep 2002 15:18:11 -0400
Date: Wed, 25 Sep 2002 16:23:09 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mark Veltzer <mark@veltzer.org>
cc: Mark Mielke <mark@mark.mielke.cc>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Peter Svensson <petersv@psv.nu>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
In-Reply-To: <200209251929.g8PJTPN05751@www.veltzer.org>
Message-ID: <Pine.LNX.4.44L.0209251621000.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Mark Veltzer wrote:

> This is terrific!!! How come something like this was not merged in
> earlier ?!? This seems like an absolute neccesity!!! I'm willing to test
> it if that is what is needed to get it merged.

You can grab the fair scheduler patch from my home page:

	http://surriel.com/patches/

> What does Linus and others feel about this and most importantly when
> will see it in ? (Hopefully in this development cycle).

I have no idea what Linus and others think about this patch,
but I know I'll need to forward-port the thing to the O(1)
scheduler first, we can ask them after that is done ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

