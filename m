Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbRE0Vfk>; Sun, 27 May 2001 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbRE0Vfa>; Sun, 27 May 2001 17:35:30 -0400
Received: from chromium11.wia.com ([207.66.214.139]:37638 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S262384AbRE0VfS>; Sun, 27 May 2001 17:35:18 -0400
Message-ID: <3B117412.A196A70C@chromium.com>
Date: Sun, 27 May 2001 14:39:30 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac1 won't boot with 4GB bigmem option
In-Reply-To: <E15482F-0002Mz-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> >  > mm: critical shortage of bounce buffers.
> >
> > Indeed this message has been pestering me in all the recent .4-acx kernels when
> > the machine is under heavy FS pressure.
> >
> > In these kernels I observe a significative (5-10%) performance degradation as
> > soon as the FS cache fills up all the available memory, at this moment "kswapd"
>
> Its there to prove we had a problem

granted

> > 2.4.2-acx and early 2.4.3-acx kernles were much better in this respect and a lot
> > more stable.
>
> Hit any 2.4 kernel pre 2.4.5 vanilla [maybe fixed] and you will break bigmem
> that way.

I've been using many kernels (I upgrade every week or so) and as far as I can
recollect I started experiencing serious performance problems with the 2.4.4 series.
I'm double checking my data right now with older kernels.

 - Fabio


