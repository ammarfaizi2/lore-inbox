Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSHUNjK>; Wed, 21 Aug 2002 09:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSHUNjK>; Wed, 21 Aug 2002 09:39:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31982 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318285AbSHUNjJ>; Wed, 21 Aug 2002 09:39:09 -0400
Subject: Re: PNPBIOS support -- 2.4.20pre3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Garst R. Reese" <reese@isn.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D63041B.165F30D1@isn.net>
References: <3D5E471A.5990F8D9@isn.net>
	<1029612095.4647.7.camel@irongate.swansea.linux.org.uk> 
	<3D5EB4EB.B1F128B2@isn.net>
	<1029618032.4809.78.camel@irongate.swansea.linux.org.uk> 
	<3D63041B.165F30D1@isn.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 14:44:11 +0100
Message-Id: <1029937451.26533.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 04:08, Garst R. Reese wrote:
> Alan Cox wrote:
> > 
> > On Sat, 2002-08-17 at 21:41, Garst R. Reese wrote:
> > > > Only in -ac currently
> > > Thanks Alan. It turns out that 2.4.20pre3 hangs on boot for me, so I'm
> > > back to 2.4.19. Will ac4 do?
> > 
> > 2.4.19-ac4 should do or 2.4.20pre2-ac3 has the very newest IDE code
> Thanks Alan. 2.4.19-ac4 + pcmcia-cs finally removed the embarrasing
> necessity of booting windows to enable/disable my ThinkPad Ir
> port/serial port. Any idea when PNPBIOS support will make it to a
> standard kernel?

Its already in 2.5.

I'm currently having fun with the thinkpad600 docking station btw. I've
now got warm docking kind of working

