Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262150AbREQVED>; Thu, 17 May 2001 17:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbREQVDn>; Thu, 17 May 2001 17:03:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16133 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262137AbREQVDe>;
	Thu, 17 May 2001 17:03:34 -0400
Date: Thu, 17 May 2001 18:03:19 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Chris Evans <chris@scary.beasts.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105171934210.366-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105171802170.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Mike Galbraith wrote:

> > Has anyone benched 2.4.5pre3 vs 2.4.4 vs. ?
> 
> Only doing parallel kernel builds.  Heavy load throughput is up,
> but it swaps too heavily.  It's a little too conservative about
> releasing cache now imho. (keeping about double what it should be
> with this load.. easily [thump] tweaked;)

"about double what it should be"

That's an interesting statement, unless you have some
arguments to define exactly how much cache the system
should keep.

Or are you just comparing with 2.2 and you'd rather
have 2.2 performance? ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

