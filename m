Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289757AbSBSTfy>; Tue, 19 Feb 2002 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289377AbSBSTfp>; Tue, 19 Feb 2002 14:35:45 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:53256 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289581AbSBSTff>;
	Tue, 19 Feb 2002 14:35:35 -0500
Date: Tue, 19 Feb 2002 16:35:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH *] new struct page shrinkage
In-Reply-To: <20020219113217.P26350@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L.0202191634290.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Larry McVoy wrote:

> This is really a problem for bkbits to solve if I understand it
> correctly. Rik wants to "name" his tree.  If we the bkbits admin
> interface have a "desc" command which changes the description listed
> on the web pages, then I think he'll be happy, right?

Indeed.  The problem was that I was getting too many trees
on linuxvm.bkbits.net and would only end up confusing people
what was what...

> I'd suggest a changeset to the config file which says
>
> # Don't change the description unless you are Linus.

Nice warning ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

