Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSGTVjS>; Sat, 20 Jul 2002 17:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSGTVjS>; Sat, 20 Jul 2002 17:39:18 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40977 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317538AbSGTVjS>; Sat, 20 Jul 2002 17:39:18 -0400
Date: Sat, 20 Jul 2002 18:42:03 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
In-Reply-To: <Pine.LNX.4.44.0207201351160.1552-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0207201838430.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, Linus Torvalds wrote:
> On Sat, 20 Jul 2002, Rik van Riel wrote:
> >
> > OK, I'll try to forward-port Ed's code to do that from 2.4 to 2.5
> > this weekend...
>
> Side note: while I absolutely think that is the right thing to do, that's
> also the much more "interesting" change. As a result, I'd be happier if it
> went through channels (ie probably Andrew) and had some wider testing
> first at least in the form of a CFT on linux-kernel.

Absolutely. This idea has been implemented but hasn't yet
received wider testing.

I guess I'll try to get this patch on LWN with a large
CFT attached ;)))

> [ Or has it already been in 2.4.x in any major tree?

Not yet. I'll pass it on through Andrew...

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

