Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271014AbRHOETH>; Wed, 15 Aug 2001 00:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271015AbRHOES4>; Wed, 15 Aug 2001 00:18:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:7438 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271014AbRHOESm>;
	Wed, 15 Aug 2001 00:18:42 -0400
Date: Wed, 15 Aug 2001 01:18:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: <ebuddington@wesleyan.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM (runaway kswapd) improvement 32Mb/120Mb 2.4.7-ac10 -> 2.4.8-ac4
In-Reply-To: <20010814122955.Q607@sparrow.bur.adelphia.net>
Message-ID: <Pine.LNX.4.33L.0108150117430.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Eric Buddington wrote:

> FWIW, my Omnibook 4100 (PII) with 32Mb RAM and 120Mb swap had some
> trouble with frequent bursts of 98% system time and high kswapd CPU
> usage under 2.4.7-ac10 while compiling the kernel and running festival
> (memory-intensive speech synthesizer).
>
> Currently, with 2.4.8-ac4, everything is just swell. Thanks to whoever
> did the tweaking.

That's interesting because Alan's changelog doesn't
list VM changes between 2.4.7-ac10 and 2.4.8-ac4,
except for an shmfs fix and an oom killer fix ;)

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

