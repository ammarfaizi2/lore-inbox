Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSEZSjr>; Sun, 26 May 2002 14:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316261AbSEZSjq>; Sun, 26 May 2002 14:39:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58354 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316250AbSEZSjo>; Sun, 26 May 2002 14:39:44 -0400
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020525210330.A20253@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 May 2002 20:40:44 +0100
Message-Id: <1022442044.11859.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-26 at 05:03, Larry McVoy wrote:
> Me too.  I've been here before, I was one of about 8 people who actually
> knew that AT&T should have won the BSD lawsuit because I diffed the code.
> And you can't diff it with a perl script, that simply doesn't work.  The

And then went on to cite bmap which is clearly different. Yes Larry, now
would you mind returning to the ward like a good patient 8)

> only real ways that I know of are
>     a) have a human do it, function by function
>     b) compile the code to an expression tree and then diff the expression
>        trees.

b) doesn't work because copyright does not apply to the fundamental
algorithms. If you want to look at it at that level you need to remember
there are many different implementations which are very different but
which in pure mathematics are strictly identical.

Alan

