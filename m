Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSHNNZo>; Wed, 14 Aug 2002 09:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSHNNZo>; Wed, 14 Aug 2002 09:25:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47599 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318101AbSHNNZn>; Wed, 14 Aug 2002 09:25:43 -0400
Subject: Re: [OOPS] 2.4.20-pre1-ac3, SMP (Dual PIII)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Antti Salmela <asalmela@iki.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020814161037.A22388@wasala.fi>
References: <20020814145454.A21254@wasala.fi>
	<1029328630.26226.21.camel@irongate.swansea.linux.org.uk> 
	<20020814161037.A22388@wasala.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 14:27:09 +0100
Message-Id: <1029331629.26227.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 14:10, Antti Salmela wrote:
> On Wed, Aug 14, 2002 at 01:37:10PM +0100, Alan Cox wrote:
> > On Wed, 2002-08-14 at 12:54, Antti Salmela wrote:
> > > Oopsed soon after boot up. Stable with vanilla 2.4.19. The board is Intel
> > > SDS2. dnetc was running.
> > 
> > Does vanilla 2.4.20pre1 run ok ?
> 
> Seems to work just fine.

Really we need to find which kernel the problem started with then. If
you've got the time to spend on this try 2.4.19-ac1

