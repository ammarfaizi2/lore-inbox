Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbRL2ROr>; Sat, 29 Dec 2001 12:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285043AbRL2ROh>; Sat, 29 Dec 2001 12:14:37 -0500
Received: from waste.org ([209.173.204.2]:35790 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285023AbRL2ROb>;
	Sat, 29 Dec 2001 12:14:31 -0500
Date: Sat, 29 Dec 2001 11:14:18 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33.0112271236120.1167-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.43.0112291102330.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Linus Torvalds wrote:

> So even if I used CVS or BK internally, that's not what people _gripe_
> about.  People want write access, not just a SCM.

Not true. I for one want to do a 'cvs update' to get current and be able
to look at revision logs and keep my own branches and merge them onto the
tip.  Sure, I can do this manually, but an SCM makes this quite a bit
easier.

Other useful tools are things like CVS blame:

http://bonsai.mozilla.org/cvsblame.cgi?file=mozilla/Makefile.in

(not sure how this would be done with single user check-in, but there's
probably a way to hack it in)

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

