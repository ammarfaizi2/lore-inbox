Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRG0WDK>; Fri, 27 Jul 2001 18:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRG0WDA>; Fri, 27 Jul 2001 18:03:00 -0400
Received: from Expansa.sns.it ([192.167.206.189]:34566 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265149AbRG0WCw>;
	Fri, 27 Jul 2001 18:02:52 -0400
Date: Sat, 28 Jul 2001 00:02:15 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Chris Wedgwood <cw@f00f.org>
cc: Hans Reiser <reiser@namesys.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <20010728030255.A804@weta.f00f.org>
Message-ID: <Pine.LNX.4.33.0107280000420.31598-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Sat, 28 Jul 2001, Chris Wedgwood wrote:

> On Fri, Jul 27, 2001 at 06:55:09PM +0400, Hans Reiser wrote:
>
>     Don't use RedHat with ReiserFS, they screw things up so many
>     ways.....
>
>     For instance, they compile it with the wrong options set, their
>     boot scripts are wrong, they just shovel software onto the CD.
>
>     Use SuSE, and trust me, ReiserFS will boot faster than ext2.
>
>     Actually, I am curious as to exactly how they manage to make
>     ReiserFS boot longer than ext2.  Do they run fsck or what?
>
> FWIW, Debian although it doesn't support reiserfs "out of the box" at
> present, works flawlessly for a large number of people I know.  I also
> hear Mandrake 7.2 and 8.0 work pretty nice if you want a pointy-clicky
> experience :)
>
I could add that also slackware is just faster with / with reiserFS
than with ext2.
But i saw that some of RH init script are, how can I say, redundant....

Luigi

> Since so many people seem to run RedHat, perhaps it's worth someone
> determining exactly what is busted with their init scripts or whatever
> that makes reiserfs barf more often that with other distributions.
>
>
>
>   --cw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

