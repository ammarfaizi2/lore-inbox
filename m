Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSFCCE2>; Sun, 2 Jun 2002 22:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317254AbSFCCE1>; Sun, 2 Jun 2002 22:04:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:5526 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317253AbSFCCE0>; Sun, 2 Jun 2002 22:04:26 -0400
Date: Sun, 2 Jun 2002 21:04:20 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Sam Ravnborg <sam@ravnborg.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Ion Badulescu <ionut@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <E17EX5v-0000Qd-00@starship>
Message-ID: <Pine.LNX.4.44.0206022051170.32102-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, Daniel Phillips wrote:

> > Can we agree that it makes sense to add features one-by-one when
> > they are independent?
> 
> Oh absolutely, and have you looked at the current factoring?
> 
>    http://marc.theaimsgroup.com/?a=102296100300003&r=1&w=2
> 
> This is still being improved, of course.

Actually, I was about to answer that issue in a reply to the mail by
Thunder, where he said that he can do a lot of patches, which do not have
any effect. Sam did actually state it already, it's not about adding which
have no effect, it's about patches which do change one thing at a time. N
patches which don't change anything and then number N+1 which changes
everything doesn't help the situation at all.

> Well, actually a lot of the work done by Kai is simply importing
> portions of Keith's work that break out easily, which is purely
> duplication of effort, since such work is already in progress.  In
> fact it creates more work, because then we have to go parse Kai's
> patches and find out what he submitted, then see if it gets applied
> so we can mark it 'applied' in the list.  This is a real waste of
> time, and did I mention, it's divisive?

Well, thanks. Maybe you have an example of what you mean above? If I take
other people's work, I credit them, and I don't think I did so far at all,
but definitely not "a lot".

I will surely pick pieces, though - this is what this process is all
about.

Anyway, since you don't understand anything about the internals of the
kbuild process at all (neither kbuild-2.4 nor 2.5), as you now proved
publically multiple times, but are just aiming at proving your abilities
in making politics on l-k, don't expect me to answer any further mails on
this (and save yourself the effort to reply to this one, but I know you
won't).

--Kai

