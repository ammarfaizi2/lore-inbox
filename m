Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136917AbRAHF0k>; Mon, 8 Jan 2001 00:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136934AbRAHF0W>; Mon, 8 Jan 2001 00:26:22 -0500
Received: from www.wen-online.de ([212.223.88.39]:28686 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S136917AbRAHF0I>;
	Mon, 8 Jan 2001 00:26:08 -0500
Date: Mon, 8 Jan 2001 06:25:53 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: barryn@pobox.com
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: posix_types.h  error
In-Reply-To: <200101072248.OAA01920@cx518206-b.irvn1.occa.home.com>
Message-ID: <Pine.Linu.4.10.10101080612530.1615-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Barry K. Nathan wrote:

> Mike Galbraith wrote:
> > On Sun, 7 Jan 2001, Richard B. Johnson wrote:
> [snip]
> > > None of the named compilers gripe? Where, prey tell, do I get the source-
> > > code of a compiler that works? The only source provided in the site
> > > listed in the Documentation does not.
> > 
> > It's not the only source there.. egcs-1.1.2 is there as well.  You can
> > also try egcs.cygnus.com/pub/egcs or a mirror.
> 
> Richard is asking for source code. Documentation/Changes only gives the
> location of binaries.

Oops.. didn't notice that there was no source in the egcs-1.1.2 directory.

> This is a bit of a problem IMO (I also tried, and failed, to find the egcs
> 1.1.2 source code). Now that I know where it is, I'll soon post a patch
> for Documentation/Changes...

Good idea.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
