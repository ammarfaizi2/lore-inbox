Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267460AbSLSA1k>; Wed, 18 Dec 2002 19:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbSLSA1k>; Wed, 18 Dec 2002 19:27:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6890
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267460AbSLSA1j>; Wed, 18 Dec 2002 19:27:39 -0500
Subject: Re: Linux 2.4.21-pre2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, mikael.starvik@axis.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021218233146.A2399@infradead.org>
References: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva> 
	<20021218233146.A2399@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 01:16:07 +0000
Message-Id: <1040260567.26906.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 23:31, Christoph Hellwig wrote:
> > <mikael.starvik@axis.com>:
> >   o CRIS architecture update for 2.4.21
> 
> This seems to include some strange stuff.
> 
> It reverts the s/extern __inline__/static __inline__/g changes
> in include/asm-cris/ and adds a junk file in
> arch/cris/drivers/bluetooth/bt.patch

Dunno where the junk came from. I'll review the other one - its from me
not from Axis, although if Axis would glance over and fixup the ide bits
that would be great as its not a platform I have access too


