Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264866AbRFYQZZ>; Mon, 25 Jun 2001 12:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbRFYQZF>; Mon, 25 Jun 2001 12:25:05 -0400
Received: from www.wen-online.de ([212.223.88.39]:23304 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264864AbRFYQZD>;
	Mon, 25 Jun 2001 12:25:03 -0400
Date: Mon, 25 Jun 2001 18:14:55 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Thrashing WITHOUT swap.
In-Reply-To: <993456815.2339.2.camel@nomade>
Message-ID: <Pine.LNX.4.33.0106251813250.811-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jun 2001, Xavier Bestel wrote:

> On 24 Jun 2001 22:36:25 +0100, Alan Cox wrote:
> > > recompiled it yet).  I have a 140 mb swap partition set up but at the time
> > > this happened it was OFF.  I was (still am) running X + twm + two xterms
> > >
> > > top gives me:
> > > mem: 62144k av, 61180k used, 956k free, 0k shrd, 76 buff, 2636 cached
> > > swap: 0k av, 0k used, 0k free [as expected]
> >
> > Not as expected - 0k used 0k free - you have no swap
>
> That's what he said. *WITHOUT* swap.

:)) yeah, exactly what Alan said.

	-Mike

