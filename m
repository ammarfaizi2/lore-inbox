Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbSJGCdU>; Sun, 6 Oct 2002 22:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbSJGCdU>; Sun, 6 Oct 2002 22:33:20 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:21460 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262489AbSJGCdT>; Sun, 6 Oct 2002 22:33:19 -0400
Date: Sun, 6 Oct 2002 23:38:44 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Larry McVoy <lm@bitmover.com>
cc: Ben Collins <bcollins@debian.org>, Nicolas Pitre <nico@cam.org>,
       Ulrich Drepper <drepper@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021006192950.A3649@work.bitmover.com>
Message-ID: <Pine.LNX.4.44L.0210062334430.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Larry McVoy wrote:

> > People can grab the repository for use with CSSC from:
> >
> > 	ftp://nl.linux.org/pub/linux/bk2patch/
>
> Make sure you do a
> 	bk -r admin -Znone
> on that tree.  We support gzipped repos, SCCS/CSSC don't.

Thanks for the advise, I'm running this command right now.

Does this need to be run every time I pull changes into the
tree or is it enough that I run it once ?


Now, with any vendor locking arguments out of the way the
various source control systems should be able to compete on
a level ground.  If you (for random values of 'you') want
to put the Linux kernel source in another source control
system and/or you develop another source control system, you
won't need bitkeeper in order to do so ...

I won't be holding my breath for a better tool than bitkeeper,
though ... it'll probably be quite a while for the other source
control tools to come close to the functionality I'm using on
a daily basis ;)


regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

