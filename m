Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSJVBgP>; Mon, 21 Oct 2002 21:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbSJVBgP>; Mon, 21 Oct 2002 21:36:15 -0400
Received: from mariscal.onda.com.br ([200.195.192.30]:5615 "EHLO
	mariscal.onda.com.br") by vger.kernel.org with ESMTP
	id <S261875AbSJVBfT>; Mon, 21 Oct 2002 21:35:19 -0400
Date: Mon, 21 Oct 2002 22:35:53 -0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Miles Lane <miles.lane@attbi.com>, LKML <linux-kernel@vger.kernel.org>,
       laredo@gnu.org
Subject: Re: 2.5.43 -- media/video/stradis.c in function `saa_open':1949: structure has no member named `busy'
Message-ID: <20021022003553.GC355@cathedrallabs.org>
References: <1034760289.3983.15.camel@turbulence.megapathdsl.net> <1035213364.28189.156.camel@irongate.swansea.linux.org.uk> <1035217590.8460.68.camel@jellybean> <1035223577.27318.228.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035223577.27318.228.camel@irongate.swansea.linux.org.uk>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2002-10-21 at 17:26, Miles Lane wrote:
> > > > drivers/media/video/stradis.c:1949: structure has no member named `busy'
> > > > drivers/media/video/stradis.c: In function `saa_close':
> > > > drivers/media/video/stradis.c:1961: structure has no member named `busy'
> > > 
> > > Not updated to 2.5. Nobody with a card is currently interested in that
> > > so if you have one its your turn to fix stuff ;)
> > 
> > Ah.  I was doing some configuration testing and don't have that
> > hardware.  Perhaps the driver should be removed from the tree?
> 
> Perhaps someone would like to fix it, if so removing it is wrong
Nathan told me that he will update this driver soon, so it's wrong :)

-- 
aris
