Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbSJFVRE>; Sun, 6 Oct 2002 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJFVRE>; Sun, 6 Oct 2002 17:17:04 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:56967 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262195AbSJFVRD>; Sun, 6 Oct 2002 17:17:03 -0400
Date: Sun, 6 Oct 2002 18:22:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Larry McVoy <lm@bitmover.com>
cc: Troy Benjegerdes <hozer@hozed.org>, Hans Reiser <reiser@namesys.com>,
       walt <wa1ter@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021006105821.L29486@work.bitmover.com>
Message-ID: <Pine.LNX.4.44L.0210061811100.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Larry McVoy wrote:

> If we GPL it or we allow clones, all that does is stop the development.
> It's not a question of is there the ability in the community to do what
> we do, there certainly is. It's a question of will they.  And the answer
> is no they won't or they would have already.

As usual, I agree with this point and think it's worth highlighting.

The GPL fanatics can flame me all they want, but that's not going
to change the reality.  The only thing that _will_ change the
situation is a team of people getting together to develop a GPL
alternative to bitkeeper.

Subversion isn't it, we can't work from the same repository with
tens of thousands of people, any BK replacement would have to be
a distributed system.

PRCS2 might become a suitable system, if somebody gets around to
picking up its development.  Arch might work too, but I remember
talking to some Arch fans a while back who "were about to" import
the whole kernel history into an Arch repository ... the fact
that I never heard from them again makes it look like maybe Arch
couldn't yet handle a repository the size of the kernel.

In short, until somebody builds a free (as in RMS-free) source
control system that's as good as bitkeeper for what the kernel
needs, bitkeeper is the only available tool for the job.

If you (for random values of you) care enough about bitkeeper
not being free, you should probably implement something as good
as, or better, than bitkeeper ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

