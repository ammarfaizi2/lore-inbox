Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280989AbRKGVQP>; Wed, 7 Nov 2001 16:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280991AbRKGVPr>; Wed, 7 Nov 2001 16:15:47 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:23313 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281005AbRKGVO7>;
	Wed, 7 Nov 2001 16:14:59 -0500
Date: Wed, 7 Nov 2001 19:14:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Tim Jansen <tim@tjansen.de>,
        =?iso-8859-1?Q?Jakob_=D8stergaard_?= <jakob@unthought.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011107012009.B35@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33L.0111071913590.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Pavel Machek wrote:

> > > It eats CPU, it's error-prone, and all in all it's just "wrong".
> >
> > How much of your CPU time is spent parsing /proc files?
>
> 30% of 486 if you run top... That's way too much and top is unusable
> on slower machines.
> "Not fast enough for showing processes" sounds wery wrong.

Is this time actually spent parsing ascii, or is it procfs
walking all the page tables of all processes ? ;)

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

