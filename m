Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSJGCF0>; Sun, 6 Oct 2002 22:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262407AbSJGCF0>; Sun, 6 Oct 2002 22:05:26 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:31696 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262394AbSJGCFZ>; Sun, 6 Oct 2002 22:05:25 -0400
Date: Sun, 6 Oct 2002 23:10:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ben Collins <bcollins@debian.org>
cc: Nicolas Pitre <nico@cam.org>, Ulrich Drepper <drepper@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021007020139.GY566@phunnypharm.org>
Message-ID: <Pine.LNX.4.44L.0210062308290.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Ben Collins wrote:

> > Whoops, forgot one thing.  Take the GNU CSSC sources, they look for
> >
> > 	^Ah%05u\n
>
> Here's a patch for those interested

People can grab the repository for use with CSSC from:

	ftp://nl.linux.org/pub/linux/bk2patch/

Or using rsync:
	rsync -rav --delete nl.linux.org::kernel/linux-2.4 linux-2.4
	rsync -rav --delete nl.linux.org::kernel/linux-2.5 linux-2.5

Currently these repositories are updated every two hours, but if
there is a large demand I could update it every hour or even every
30 minutes.  Don't feel ashamed to put the above rsyncs into your
crontabs, grab the source and use it ;)

have fun,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

