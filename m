Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283223AbRLRAda>; Mon, 17 Dec 2001 19:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283265AbRLRAdV>; Mon, 17 Dec 2001 19:33:21 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:59143 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283223AbRLRAdI>;
	Mon, 17 Dec 2001 19:33:08 -0500
Date: Mon, 17 Dec 2001 22:32:53 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
In-Reply-To: <20011217165845.C2431@athlon.random>
Message-ID: <Pine.LNX.4.33L.0112172232180.15741-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Andrea Arcangeli wrote:
> On Mon, Dec 17, 2001 at 06:21:53PM +0100, Ingo Molnar wrote:
> > On Mon, 17 Dec 2001, Andrea Arcangeli wrote:
> >
> > > This whole long thread can be resumed in two points:
> > >
> > > 1	mempool reserved memory is "wasted" i.e. not usable as cache
> >
> > reservations, as in Ben's published (i know, incomplete) implementation,
> > are 'wasted' as well.
>
> yes, I was referring only about his long term design arguments.

Long term design arguments don't have to make the short-term
implementation any more complex. I guess you presented a nice
argument to go with the more flexible solution.

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

