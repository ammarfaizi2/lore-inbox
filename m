Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264728AbRFXVJp>; Sun, 24 Jun 2001 17:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264722AbRFXVJf>; Sun, 24 Jun 2001 17:09:35 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:12489 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S264737AbRFXVJQ>;
	Sun, 24 Jun 2001 17:09:16 -0400
Date: Sun, 24 Jun 2001 23:09:14 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <dhinds@zen.stanford.edu>
Subject: Re: [PATCH] add kmalloc check in drviers/pcmcia/rsrc_mgr.c (245-ac16)
In-Reply-To: <20010624230126.F847@jaquet.dk>
Message-ID: <Pine.LNX.4.33.0106242306310.3517-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Jun 2001, Rasmus Andersen wrote:
> On Sun, Jun 24, 2001 at 10:52:31PM +0200, Eric Lammerts wrote:
> [...]
> > There are zillions of functions called 'init_module' in the kernel.
> > I think my suggestion was better (and it had a \n at the end!)
>
> Agreed. Actually, 'ouch' on point two :) BTW, was it intentional
> that you dropped the maintainer from the recipient-list back then?

No, sorry.

Eric

