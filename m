Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280203AbRKZK7j>; Mon, 26 Nov 2001 05:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRKZK73>; Mon, 26 Nov 2001 05:59:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:57868 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280612AbRKZK7Y>;
	Mon, 26 Nov 2001 05:59:24 -0500
Date: Mon, 26 Nov 2001 08:59:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        Dominik Kubla <kubla@sciobyte.de>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
In-Reply-To: <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0111260857150.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, Linus Torvalds wrote:

> The _real_ solution is to make fewer fundamental changes between
> stable kernels, and that's a real solution that I expect to become
> more and more realistic as the kernel stabilizes.

Agreed, this would make a _lot_ of difference in the time it
takes to get a new stable kernel really stable.

> But you also have to realize that "fewer fundamental changes" is a
> mark of a system that isn't evolving as quickly, and that is reaching
> middle age. We are probably not quite there yet ;)

Doesn't mean we need to get _all_ our TODO items done in
2.5.  I really don't see what's wrong with doing only a
few in 2.5 and delaying the rest for 2.7, especially not
when both 2.5 and 2.7 happen quickly ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

