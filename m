Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSAGRDP>; Mon, 7 Jan 2002 12:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbSAGRCz>; Mon, 7 Jan 2002 12:02:55 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:48911 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280588AbSAGRCw>;
	Mon, 7 Jan 2002 12:02:52 -0500
Date: Mon, 7 Jan 2002 15:02:34 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: christian e <cej@ti.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: swapping,any updates ?? Just wasted money on mem upgrade
 performance still suck :-(
In-Reply-To: <3C39CC9C.20505@ti.com>
Message-ID: <Pine.LNX.4.33L.0201071501100.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, christian e wrote:
> M. Edward (Ed) Borasky wrote:
>
> > Thank you, Alan!! Now if the *other* kernel developers would just buy
> > into this. :)
>
> Exactly.Please think about what Alan just said.You just can't satisfy
> everyone in every situation without tweaking.That's the way it is.

There are a few things to keep in mind, however:

1) the default settings shouldn't result in any system
   falling apart, it really should work everywhere
   (though possibly slower than after tweaking)

2) the tunables should make sense and be easy enough
   to tune without first needing to understand all of
   the VM internals

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

