Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262524AbSJGDCG>; Sun, 6 Oct 2002 23:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262530AbSJGDCG>; Sun, 6 Oct 2002 23:02:06 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:4056 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262524AbSJGDCF>; Sun, 6 Oct 2002 23:02:05 -0400
Date: Mon, 7 Oct 2002 00:07:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Larry McVoy <lm@bitmover.com>
cc: Ben Collins <bcollins@debian.org>, Nicolas Pitre <nico@cam.org>,
       Ulrich Drepper <drepper@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <Pine.LNX.4.44L.0210062334430.22735-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44L.0210070006140.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Rik van Riel wrote:
> On Sun, 6 Oct 2002, Larry McVoy wrote:
>
> > > 	ftp://nl.linux.org/pub/linux/bk2patch/
> >
> > Make sure you do a
> > 	bk -r admin -Znone
> > on that tree.  We support gzipped repos, SCCS/CSSC don't.
>
> Thanks for the advise, I'm running this command right now.

If you worried why your rsync session just died ... I killed it
after finishing uncompressing the repositories.  From now on
you'll get an uncompressed repository that SCCS/CSSC can handle.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

