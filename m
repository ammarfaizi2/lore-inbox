Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287671AbRLaW0q>; Mon, 31 Dec 2001 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287669AbRLaW0g>; Mon, 31 Dec 2001 17:26:36 -0500
Received: from www.transvirtual.com ([206.14.214.140]:7431 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S287673AbRLaW0U>; Mon, 31 Dec 2001 17:26:20 -0500
Date: Mon, 31 Dec 2001 14:26:04 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Scott McDermott <vaxerdec@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <20011231195655.A16870@conectiva.com.br>
Message-ID: <Pine.LNX.4.10.10112311425020.12522-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Text mode is slow and has poor resolution, yes even svga text mode stuff
> > is way slower than accelerated fbconsole for me, I don't like having to
> > wait for the screen to update when I page a file and go to the next
> > page.
> 
> ouch, this hasn't been the case for me for ages, maybe I should try this
> accelerated fbconsole thing again...

Which framebuffer driver? Soem are good and some suck. Vesafb is really
bad. It far better to use a native card dr4iver if it is avaliable.


