Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293075AbSBWBox>; Fri, 22 Feb 2002 20:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293077AbSBWBop>; Fri, 22 Feb 2002 20:44:45 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:8206 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293075AbSBWBod>; Fri, 22 Feb 2002 20:44:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 22 Feb 2002 17:46:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Tom Rini <trini@kernel.crashing.org>, Rik van Riel <riel@conectiva.com.br>,
        Christoph Hellwig <hch@caldera.de>, <hpa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 bitkeeper repository
In-Reply-To: <20020222173222.E11156@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0202221744290.1484-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Larry McVoy wrote:

> On Fri, Feb 22, 2002 at 05:35:13PM -0700, Tom Rini wrote:
> > > You forgot about setting the proper BK_USER, BK_HOST and
> > > 'bk comment' commands ;)
> >
> > heh.  Those are rather new things, aren't they? :)  Anyhow, the goal for
> > these tree(s) is to keep the PPC children trees up to date.
>
> BK_USER, BK_HOST have been around forever but their use is discouraged for
> the following reason: BK is a distributed system, we need unique names for
> things, and the user&host are part of the name we make up.
>
> bk comments is new and a darned useful thing, too, I'm glad Linus asked
> for it.  You just have to read the man page and realize that your updates
> to the comments may not propogate.

Larry, i've a question for you.
Does BK use the same basic algos of diff+patch ?
Or, if CVS fails a merge, what is the probability that BK will succeed on
the same op ?



- Davide


