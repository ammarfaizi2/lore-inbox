Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSJFRCr>; Sun, 6 Oct 2002 13:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261705AbSJFRCr>; Sun, 6 Oct 2002 13:02:47 -0400
Received: from pop018pub.verizon.net ([206.46.170.212]:46801 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S261701AbSJFRCq>; Sun, 6 Oct 2002 13:02:46 -0400
Message-Id: <200210061703.g96H3w1I004486@pool-141-150-241-241.delv.east.verizon.net>
Date: Sun, 6 Oct 2002 13:03:57 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <3D9F49D9.304@redhat.com> <20021005162852.I11375@work.bitmover.com> <1033861827.4441.31.camel@irongate.swansea.linux.org.uk> <anoivq$35b$1@penguin.transmeta.com> <200210060743.g967hEWf000528@pool-141-150-241-241.delv.east.verizon.net> <20021006163831.GA16144@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021006163831.GA16144@conectiva.com.br>; from acme@conectiva.com.br on Sun, Oct 06, 2002 at 01:38:32PM -0300
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop018.verizon.net from [141.150.241.241] at Sun, 6 Oct 2002 12:08:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> Em Sun, Oct 06, 2002 at 03:43:08AM -0400, Skip Ford escreveu:
> > Linus Torvalds wrote:
>  
> > > I don't do any pre-patches or daily patches any more, because it's all
> > > automated.  There are several snapshot bots that give you patches a lot
> > > more often than "every 2 days".  You don't need BK to use it, it's there in
> > > the good old diff format. 
> 
> > However, a much larger percentage of patches are applied to your tree without
> > a diff being posted to lkml first.  My only wish would be that you only
> > accept patches through the mailing list, and only from posts that include at
> > least a link to a diff.
> 
> Are you dying to see X.25, lapbether, LLC, IPX and other non-sexy/mainstream
> patches here? I can start doing it for the stuff I've been sending only via
> bitkeeper to David Miller, I'm mostly alone in this and having people
> commenting on it would be great, but I don't think that people that have
> interest in this aren't helping/commenting because I don't post the changesets
> here, after all if they're interested they can use the regular releases from
> Linus or the diffs provided by bot services generally available.

I was thinking more of just sharing the code.  There are more trees out
there than just Linus'.  Deciding to apply one of your patches is much
easier if we have the specific patch, rather than just a 600k patch from
Linus that happens to include your patch buried inside it.

> If people think that this will help with development of the stuff I work with,
> please say so.
> 
> Patches that touches the networking core, etc, I post to netdev, and not here,
> and this is done by lots of other people, for several subsystems, and
> contributes to the feeling that things are not being posted to lkml. They are
> not, never had, nothing new, only BK has a license people disagree with and all
> of a sudden is the reason for patches not being more reviewed, etc. I beg to
> disagree.

I'm not bitching about bk here.  It's clearly improved Linus'
productivity.  I don't use it, but I like Linus using it.  And with
the udiff-ing of each changeset, I can see each patch he applied, even
if it wasn't sent to lkml.  That wasn't possible before bk.  It's the
next best thing to actually having the author of the patch think others
may want the same patch Linus wants.

-- 
Skip
