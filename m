Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135192AbRAGQiZ>; Sun, 7 Jan 2001 11:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135493AbRAGQiP>; Sun, 7 Jan 2001 11:38:15 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20207 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S135192AbRAGQiI>; Sun, 7 Jan 2001 11:38:08 -0500
Date: Sun, 7 Jan 2001 14:37:47 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.x patch submission policy
In-Reply-To: <937neu$p95$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101071434370.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2001, Linus Torvalds wrote:

> In short, releasing 2.4.0 does not open up the floor to just
> about anything.  In fact, to some degree it will probably make
> patches _less_ likely to be accepted than before, at least for a
> while.

I think this is an excellent idea. To help with this I'll
gather all non-bug VM patches and combine them into a
special big patch periodically.

Once we are sure 2.4 is stable for just about anybody I
will submit some of the really trivial enhancements for
inclusion; all non-trivial patches I will maintain in a
VM bigpatch, which will be submitted for inclusion around
2.5.0 and should provide one easy patch for those distribution
vendors who think 2.4 VM performance isn't good enough for
them ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
