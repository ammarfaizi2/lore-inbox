Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSBST2E>; Tue, 19 Feb 2002 14:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289339AbSBST1y>; Tue, 19 Feb 2002 14:27:54 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17672 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289484AbSBST1o>;
	Tue, 19 Feb 2002 14:27:44 -0500
Date: Tue, 19 Feb 2002 16:27:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH *] new struct page shrinkage
In-Reply-To: <Pine.LNX.4.33.0202191116470.27806-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0202191625590.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Linus Torvalds wrote:
> On Tue, 19 Feb 2002, Rik van Riel wrote:
> >
> > The patch has been changed like you wanted, with page->zone
> > shoved into page->flags. I've also pulled the thing up to
> > your latest changes from linux.bkbits.net so you should be
> > able to just pull it into your tree from:
> >
> > bk://linuxvm.bkbits.net/linux-2.5-struct_page
>
> Btw, _please_ don't do things like changing the bitkeeper etc/config file.
> Right now your very first changesets is something that I definitely do not
> want in my tree.

Woooops, I was trying to make the overview on linuxvm.bkbits.net
display something sensible but didn't realise you'd be pulling
that back into your tree ;((((

I'll make sure to not make this mistake again.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

