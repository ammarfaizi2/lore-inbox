Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290200AbSA3Qzk>; Wed, 30 Jan 2002 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290078AbSA3QyL>; Wed, 30 Jan 2002 11:54:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55496 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290175AbSA3Qxp>;
	Wed, 30 Jan 2002 11:53:45 -0500
Date: Wed, 30 Jan 2002 19:51:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33L.0201301445430.11594-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0201301949190.11581-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Rik van Riel wrote:

> On Wed, 30 Jan 2002, Ingo Molnar wrote:
>
> > could this be made: 'as long as they do not touch the same lines of
> > code, taking 3 lines of context into account'? (ie. unified diff
> > definition of 'collisions' context.)
>
> That would be _wonderful_ and fix the last bitkeeper problem I'm
> having once in a while.

perhaps there should also be some sort of authority needed to allow such
'violation' of current BK rules: while the patches to conflict in terms of
source code file, we can override it and tell it that they really dont
conflict.

	Ingo

