Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSEZUcP>; Sun, 26 May 2002 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSEZUcO>; Sun, 26 May 2002 16:32:14 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:44788 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315239AbSEZUcO>; Sun, 26 May 2002 16:32:14 -0400
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020526120630.C30610@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 May 2002 22:33:14 +0100
Message-Id: <1022448794.11811.142.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-26 at 20:06, Larry McVoy wrote:
> > there are many different implementations which are very different but
> > which in pure mathematics are strictly identical.
> 
> Is this theory or practice, Alan?  We're not talking about pure copyright,
> we're also discussing derived works.  And anyway, I'd like you to cite a
> case where two independently developed substantial chunks of code compile
> to the same expression tree.  I'm sure you can find strcmp() implementations
> which do, but I'd be surprised if you could find a stdio implementation that
> was, and you sure as hell won't find two file system implementations that do.
> Righ?  Or do you have a counter example?

I was very careful to say "pure mathematics". With perfect optimisation
all implementations of the same algorithm should produce the same parse
tree.

I can think of lots of trivial counter examples. The most obvious of
which is that given any set beginning pascal type homework the parse
tree of all the implementations with the noise/comments/names filtered
out is probably going to be identical.

The same exercise on library implementations of qsort, strcmp and so
forth are probably also going to show that.

