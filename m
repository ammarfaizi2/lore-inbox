Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263141AbSJFAr4>; Sat, 5 Oct 2002 20:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263155AbSJFArz>; Sat, 5 Oct 2002 20:47:55 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:215 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263141AbSJFArx>; Sat, 5 Oct 2002 20:47:53 -0400
Date: Sat, 5 Oct 2002 21:53:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ben Collins <bcollins@debian.org>
cc: Larry McVoy <lm@work.bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021006003217.GD585@phunnypharm.org>
Message-ID: <Pine.LNX.4.44L.0210052152390.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Ben Collins wrote:

> > ftp://nl.linux.org/pub/linux/bk2patch/
>
> Oh, but that may be useless, unless you regenerate your patches whenever
> the tree is reparented. I ran into this while trying to do the same
> thing. Basing it on the ChangeSet ID is a waste, and it needs to be
> based on the ChangeSet key instead (the ChangeSet ID for a given key can
> change when a merge is done).

Good point.  I'll need to look at this more closely...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

