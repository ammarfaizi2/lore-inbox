Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSJURoY>; Mon, 21 Oct 2002 13:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbSJURoY>; Mon, 21 Oct 2002 13:44:24 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28341 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261238AbSJURoX>; Mon, 21 Oct 2002 13:44:23 -0400
Subject: Re: 2.5.43 -- media/video/stradis.c in function `saa_open':1949:
	structure has no member named `busy'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Lane <miles.lane@attbi.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1035217590.8460.68.camel@jellybean>
References: <1034760289.3983.15.camel@turbulence.megapathdsl.net> 
	<1035213364.28189.156.camel@irongate.swansea.linux.org.uk> 
	<1035217590.8460.68.camel@jellybean>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 19:06:17 +0100
Message-Id: <1035223577.27318.228.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 17:26, Miles Lane wrote:
> > > drivers/media/video/stradis.c:1949: structure has no member named `busy'
> > > drivers/media/video/stradis.c: In function `saa_close':
> > > drivers/media/video/stradis.c:1961: structure has no member named `busy'
> > 
> > Not updated to 2.5. Nobody with a card is currently interested in that
> > so if you have one its your turn to fix stuff ;)
> 
> Ah.  I was doing some configuration testing and don't have that
> hardware.  Perhaps the driver should be removed from the tree?

Perhaps someone would like to fix it, if so removing it is wrong

