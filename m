Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQLORl7>; Fri, 15 Dec 2000 12:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbQLORlt>; Fri, 15 Dec 2000 12:41:49 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48913 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129745AbQLORlh>; Fri, 15 Dec 2000 12:41:37 -0500
Date: Fri, 15 Dec 2000 09:10:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre1 changelog
In-Reply-To: <20001215083744.O504@opus.bloom.county>
Message-ID: <Pine.LNX.4.10.10012150909260.2255-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Tom Rini wrote:

> On Thu, Dec 14, 2000 at 03:31:54PM -0800, Linus Torvalds wrote:
>  
> > I'm hoping that most of the fall-out from switching over exclusively to
> > the new-style Makefiles will be over in a day or two, at which point
> > I'll make a pre2 that is worth announcing.
> 
> Does this mean other arches will have a chance to sync in 2.4.0-test13?

Sparc is already sync'ed in my tree, and I'd love for other architectures
to synch up too (but if it takes a while it's not a major disaster - I
actually much prefer bugs that cause build failures over other kinds of
bugs ;).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
