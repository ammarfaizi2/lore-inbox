Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSHKNzv>; Sun, 11 Aug 2002 09:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318301AbSHKNzu>; Sun, 11 Aug 2002 09:55:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59399 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318300AbSHKNzu>; Sun, 11 Aug 2002 09:55:50 -0400
Date: Sun, 11 Aug 2002 10:59:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-atalk@lists.netspace.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.31
Message-ID: <20020811135920.GA3176@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-atalk@lists.netspace.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0208101854340.2656-100000@penguin.transmeta.com> <Pine.NEB.4.44.0208111337560.3636-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0208111337560.3636-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 11, 2002 at 01:44:15PM +0200, Adrian Bunk escreveu:
> On Sat, 10 Aug 2002, Linus Torvalds wrote:
> > Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
> >   o Appletalk: more cleanups and code reorganization
 
> The s/at_addr/atalk_addr/ in atalk.h broke the compilation of
> drivers/net/appletalk/*. The patch below fixes it.

Argh, thanks, I'll merge this in my tree.

- Arnaldo
