Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280502AbRJaUsv>; Wed, 31 Oct 2001 15:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280501AbRJaUsl>; Wed, 31 Oct 2001 15:48:41 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:5380 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280499AbRJaUs1>;
	Wed, 31 Oct 2001 15:48:27 -0500
Date: Wed, 31 Oct 2001 18:48:48 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <E15z28m-0000vb-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0110311848330.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Daniel Phillips wrote:
> On October 31, 2001 07:06 pm, Daniel Phillips wrote:
> > I just tried your test program with 2.4.13, 2 Gig, and it ran without
> > problems.  Could you try that over there and see if you get the same result?
> > If it does run, the next move would be to check with 3.5 Gig.
>
> Ben reports that his test with 2 Gig memory runs fine, as it does for
> me, but that it locks up tight with 3.5 Gig, requiring power cycle.
> Since I only have 2 Gig here I can't reproduce that (yet).

Does it lock up if your low memory is reduced to 512 MB ?

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

