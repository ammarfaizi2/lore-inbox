Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbRERWpG>; Fri, 18 May 2001 18:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbRERWo4>; Fri, 18 May 2001 18:44:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20744 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261593AbRERWos>;
	Fri, 18 May 2001 18:44:48 -0400
Date: Fri, 18 May 2001 19:44:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105182153570.387-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105181941070.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Mike Galbraith wrote:

> While I'd love to have more control, I can't say I have a clear
> picture of exactly how I'd like those knobs to look.  I always
> start out trying to get it to seek the right behavior.. :) and
> end up fighting so many different fires I get lost in the smoke.

This is the core of why we cannot (IMHO) have a discussion
of whether a patch introducing new VM tunables can go in:
there is no clear overview of exactly what would need to be
tunable and how it would help.

When you and Ingo have something more specific to talk about,
I guess we can decide on that; but deciding on something like
this isn't really possible without at least knowing what should
be tunable ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

