Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289855AbSAKEA3>; Thu, 10 Jan 2002 23:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289861AbSAKEAT>; Thu, 10 Jan 2002 23:00:19 -0500
Received: from waste.org ([209.173.204.2]:50574 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289855AbSAKEAF>;
	Thu, 10 Jan 2002 23:00:05 -0500
Date: Thu, 10 Jan 2002 21:59:43 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Rene Rebe <rene.rebe@gmx.net>, <andre@linux-ide.org>,
        <matthew@infodancer.org>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE Patch (fwd)
In-Reply-To: <3C3B59D8.9D4DD1B1@zip.com.au>
Message-ID: <Pine.LNX.4.43.0201102154180.5623-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Andrew Morton wrote:

> Rene Rebe wrote:
> >
> > I also vote for inclusion in 2.4.
>
> I spent a couple of hours beating the crap out of it,
> and none actually came out.  I'd vote for prompt inclusion
> in 2.5, and inclusion in 2.4.x-pre1 when it's shown to be
> stable.

I vote for doing the reverse. The 2.4 codebase is the more tested, the 2.5
is a forward-port. Given all the related block changes still settling out
in 2.5, changing IDE might make block layer/IDE issues hard to sort out.
Let's see it in the next 2.4.x-pre1.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

