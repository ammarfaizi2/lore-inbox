Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281915AbRKZQmK>; Mon, 26 Nov 2001 11:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281920AbRKZQlv>; Mon, 26 Nov 2001 11:41:51 -0500
Received: from imo-m10.mx.aol.com ([64.12.136.165]:60128 "EHLO
	imo-m10.mx.aol.com") by vger.kernel.org with ESMTP
	id <S281915AbRKZQls>; Mon, 26 Nov 2001 11:41:48 -0500
Message-ID: <3C026FA2.CE27DEB9@cs.com>
Date: Mon, 26 Nov 2001 09:36:50 -0700
From: Charles Marslett <cmarslett9@cs.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,zh-TW,ja
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva> <01112615070600.00943@manta>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:
> 
> On Saturday 24 November 2001 16:39, Marcelo Tosatti wrote:
> > Hi,
> >
> > So here it goes 2.4.16-pre1. Obviously the most important fix is the
> > iput() one, which probably fixes the filesystem corruption problem people
> > have been seeing.
> 
> This is quite annoying to have non-pre kernels with simple bugs like
> recent loop device bug etc.
> 
> Maybe this can be prevented by adopting a rule that non-pre kernel is made
> from last pre/ac/... which was good enough by changing version # _only_,
> without even single buglet squashing?
> 
> This way we will not disappoint those people who download non-pres in hope
> they are more stable.
> 
> Just my 2 cents.
> --
> vda

I agree.

--Charles 
          /"\                           |
          \ /     ASCII Ribbon Campaign |
           X      Against HTML Mail     |--Charles Marslett
          / \                           |  www.wordmark.org
