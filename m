Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280512AbRJaVIV>; Wed, 31 Oct 2001 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280514AbRJaVIM>; Wed, 31 Oct 2001 16:08:12 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1285 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280511AbRJaVIE>;
	Wed, 31 Oct 2001 16:08:04 -0500
Date: Wed, 31 Oct 2001 19:08:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
        Ben Smith <ben@google.com>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <E15z2X4-0000wh-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0110311907180.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Daniel Phillips wrote:
> On October 31, 2001 09:48 pm, Rik van Riel wrote:
> > On Wed, 31 Oct 2001, Daniel Phillips wrote:

> > > Ben reports that his test with 2 Gig memory runs fine, as it does for
> > > me, but that it locks up tight with 3.5 Gig, requiring power cycle.
> > > Since I only have 2 Gig here I can't reproduce that (yet).
> >
> > Does it lock up if your low memory is reduced to 512 MB ?
>
> Ben?

Nonono, I mean that if _you_ reduce low memory to 512MB
on your 2GB machine, maybe you can reproduce the problem
more easily.

If the Google people try this with larger machines, it'll
almost certainly make triggering the bug even easier ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

