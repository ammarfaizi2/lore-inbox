Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262610AbREZOlK>; Sat, 26 May 2001 10:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262581AbREZOlD>; Sat, 26 May 2001 10:41:03 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18949 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261948AbREZOks>;
	Sat, 26 May 2001 10:40:48 -0400
Date: Sat, 26 May 2001 11:40:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526163857.V9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105261139360.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:
> On Sat, May 26, 2001 at 11:21:18AM -0300, Rik van Riel wrote:
> > On Sat, 26 May 2001, Andrea Arcangeli wrote:
> > 
> > > I didn't checked the alloc_pages() other thing mentioned by Ben, if
> > > alloc_pages() deadlocks internally that's yet another completly
> > > orthogonal bug and that will be addressed by another patch if it
> > > persists.
> > 
> > O, that part is fixed by the patch that Linus threw away
> > yesterday ;)
> 
> what are you smoking?

I am smoking the "tested the patch and wasn't able to reproduce
a deadlock" stuff.

> I read your patch and there's nothing related to
> such fix in your patch.

I explained the thing to you about 5 times now. If you don't
have the time to understand the deadlock, please don't try
to confuse the issue by sending out non-fixes.


Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

