Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbRLaV5Q>; Mon, 31 Dec 2001 16:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287666AbRLaV5G>; Mon, 31 Dec 2001 16:57:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6417 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287658AbRLaV4w>;
	Mon, 31 Dec 2001 16:56:52 -0500
Date: Mon, 31 Dec 2001 19:56:55 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Scott McDermott <vaxerdec@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-ID: <20011231195655.A16870@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Scott McDermott <vaxerdec@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200112302117.fBULHISr011887@svr3.applink.net> <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com> <20011231164258.A1099@vaxerdec.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231164258.A1099@vaxerdec.homeip.net>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 31, 2001 at 04:42:58PM -0500, Scott McDermott escreveu:
> Linus Torvalds on Sun 30/12 16:19 -0800:
> > No sane person should use frame buffers if they have the choice.
> 
> Text mode is slow and has poor resolution, yes even svga text mode stuff
> is way slower than accelerated fbconsole for me, I don't like having to
> wait for the screen to update when I page a file and go to the next
> page.

ouch, this hasn't been the case for me for ages, maybe I should try this
accelerated fbconsole thing again...
 
> And why require me to load X just to have a usuable system? Yes I think

yes, why? Use lynx + zgv(in the rare cases where it is needed to see
images) ;)

> when I have to switch consoles so a program doing a lot of screen output
> doesn't block endlessly on my slow textmode display is unusable.

Thats what I feel when I use fbconsoles, and not the good old 80x25 text
mode console.

- Arnaldo
