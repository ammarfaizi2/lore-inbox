Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSLPFrC>; Mon, 16 Dec 2002 00:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbSLPFrC>; Mon, 16 Dec 2002 00:47:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9949
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265247AbSLPFrC>; Mon, 16 Dec 2002 00:47:02 -0500
Subject: Re: Linux 2.4.21-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021215095630.GD16227@charite.de>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
	<20021211090829.GD8741@charite.de>
	<1039622867.17709.31.camel@irongate.swansea.linux.org.uk>
	<20021211153414.GQ8741@charite.de> <20021211155650.GU8741@charite.de>
	<1039627740.17709.82.camel@irongate.swansea.linux.org.uk> 
	<20021215095630.GD16227@charite.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Dec 2002 06:34:06 +0000
Message-Id: <1040020446.11729.223.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-15 at 09:56, Ralf Hildebrandt wrote:
> * Alan Cox <alan@lxorguk.ukuu.org.uk>:
> 
> > The hardware isnt at the normal ide base addresse, yet the chip is
> > reporting that it isnt in native mode. As far as I can see this
> > configuration isnt allowed.
> > 
> > We see that the chip isnt in native mode so we defer to the legacy
> > scanner. Since the ports are not valid the legacy scanner doesn't find
> > them.
> 
> Will the fix be for thatbe in 2.4.20-ac3 / 2.4.21-pre2?

Soon I hope

