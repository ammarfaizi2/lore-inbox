Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283858AbRLAANt>; Fri, 30 Nov 2001 19:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283857AbRLAANe>; Fri, 30 Nov 2001 19:13:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:48656 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283853AbRLAANM>;
	Fri, 30 Nov 2001 19:13:12 -0500
Date: Fri, 30 Nov 2001 22:12:53 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <Pine.GSO.4.21.0111301226190.15083-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33L.0111302210560.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Alexander Viro wrote:

> Fact of life: we all suck at reviewing our own code.  You, me, Ken
> Thompson, anybody - we tend to overlook bugs in the code we'd written.
> Depending on the skill we can compensate - there are technics for
> that, but it doesn't change the fact that review by clued people who
> didn't write the thing tends to show bugs we'd missed for years.

Absolutely agreed.  Note that this goes hand in hand with
another issue, no matter how scary it may sound to other
people ... <drum roll>

	DOCUMENTATION

Because, without documentation we can only see what code
does and not what it's supposed to do.

This in turn means other people cannot identify bugs in
the code, simply because they're not sure what the code
is supposed to do.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

