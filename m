Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRHSAiu>; Sat, 18 Aug 2001 20:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRHSAij>; Sat, 18 Aug 2001 20:38:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34315 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269693AbRHSAif>;
	Sat, 18 Aug 2001 20:38:35 -0400
Date: Sat, 18 Aug 2001 21:38:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <Pine.LNX.4.30.0108181839130.31188-100000@waste.org>
Message-ID: <Pine.LNX.4.33L.0108182137250.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Oliver Xymoron wrote:
> On 18 Aug 2001, Robert Love wrote:
>
> > obviously some people fear NICs feeding entropy provides a hazard.  for
> > those who dont, or are increadibly low on entropy, enable the
> > configuration option.
>
> Why don't those who aren't worried about whether they _really_ have
> enough entropy simply use /dev/urandom?

So how are you going to feed /dev/urandom on your firewall ??
(which has no keyboard, program or disk activity)

Network entropy is probably better than no entropy for many
applications.

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

