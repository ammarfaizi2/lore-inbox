Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSHLKCZ>; Mon, 12 Aug 2002 06:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317653AbSHLKCZ>; Mon, 12 Aug 2002 06:02:25 -0400
Received: from unixbox.com ([207.211.45.65]:15122 "EHLO shell.unixbox.com")
	by vger.kernel.org with ESMTP id <S317642AbSHLKCY>;
	Mon, 12 Aug 2002 06:02:24 -0400
Date: Mon, 12 Aug 2002 03:18:02 -0700 (PDT)
From: Ani Joshi <ajoshi@unixbox.com>
To: Erik Andersen <andersen@codepoet.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb update vs 2.4.20-pre1
In-Reply-To: <20020811212244.GB27048@codepoet.org>
Message-ID: <Pine.BSF.4.44.0208120315510.55624-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These issues are addressed (or should be) in version 0.1.5 of radeonfb
which was posted to the fbdev list a month or so ago.  I am waiting on a
few other fixes I need to get done before I send an update to Marcelo, but
rest assured this will happen in the 2.4.20 cycle.


ani


On Sun, 11 Aug 2002, Erik Andersen wrote:

> Here is an update to the radeonfb.  This is based on a patch
> from Peter Horton that was posted to the lkml back in April
>     http://www.uwsg.indiana.edu/hypermail/linux/kernel/0204.1/0364.html
>
> I have been carrying this patch along in my own tree since April
> and I find it a huge improvement.  Using this patch, I find that
> the radeonfb is quite fast, and colors are correct.
>
> I have updated the patch to fit into 2.4.20-pre1, fixed a few
> obvious little things, and reworked the mtrr handling so it
> matches the behavior of the other framebuffers.  Any chance
> we could get this into 2.4.20?
>
>  -Erik
>
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
>

