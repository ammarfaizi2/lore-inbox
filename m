Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271518AbRHUEJP>; Tue, 21 Aug 2001 00:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRHUEI5>; Tue, 21 Aug 2001 00:08:57 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27142 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271518AbRHUEIo>;
	Tue, 21 Aug 2001 00:08:44 -0400
Date: Tue, 21 Aug 2001 01:08:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010821040433Z16007-32383+623@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108210106450.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Daniel Phillips wrote:
> On August 21, 2001 05:58 am, Rik van Riel wrote:
> > On Tue, 21 Aug 2001, Daniel Phillips wrote:
> > > This is hypothetical thrashing so far, have you see it in the wild?
> >
> > Yes.
>
> Could you supply details please?

No hard measurements since the kernel doesn't export the
statistics for all of this yet, but I've seen the behaviour
and after thinking for a few seconds I came up with the
maths I gave you before to explain the situation.

Now it's your turn to come up with the maths to back up
your assumptions.

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

