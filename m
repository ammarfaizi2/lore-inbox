Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289918AbSA3QvH>; Wed, 30 Jan 2002 11:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290119AbSA3Qtj>; Wed, 30 Jan 2002 11:49:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:11529 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290120AbSA3Qsz>;
	Wed, 30 Jan 2002 11:48:55 -0500
Date: Wed, 30 Jan 2002 14:47:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201301933390.11022-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0201301445430.11594-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Ingo Molnar wrote:
> On Wed, 30 Jan 2002, Larry McVoy wrote:
>
> > How much of the out order stuff goes away if you could send changes
> > out of order as long as they did not overlap (touch the same files)?
>
> could this be made: 'as long as they do not touch the same lines of
> code, taking 3 lines of context into account'? (ie. unified diff
> definition of 'collisions' context.)

That would be _wonderful_ and fix the last bitkeeper
problem I'm having once in a while.

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

