Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSKSMaI>; Tue, 19 Nov 2002 07:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSKSMaI>; Tue, 19 Nov 2002 07:30:08 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22199 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264653AbSKSMaH>; Tue, 19 Nov 2002 07:30:07 -0500
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: "Karsten 'soohrt' Desler" <linux-kernel@ml.soohrt.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021119113300.C23008@pc9391.uni-regensburg.de>
References: <20021119105955.A23008@pc9391.uni-regensburg.de>
	<20021119102338.GA24510@sit0.ifup.net> 
	<20021119113300.C23008@pc9391.uni-regensburg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 13:04:59 +0000
Message-Id: <1037711099.11541.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 10:33, Christian Guggenberger wrote:
> On 19.11.2002   11:23 Karsten 'soohrt' Desler wrote:
> > > I have the same board, and the controller works fine for me in 2.5.4*, as
> > > 2.4-ac doesn't contain xfs suport. I only have one drive attached, but as I
> > 
> > > remember I first had to configure the (raid) controller' BIOS (Ctrl-H at
> > boot
> > > time) (even for just a bunch of disks) before using the drives. But I'm not
> > 
> > > 100%ly sure.
> > 
> > I've "been in" the controller BIOS a few times, but never configured
> > anything because I'm using the linux md driver.
> 
> Maybe U would try 2.5.48, just to see if it works then.
> When I'm back home in about 7 hours, I'll check my bios settings, maybe this 
> could help you.

For IDE 2.5.47-ac is current head. 2.5.48 was just too weird and broken
for me to move to a 2.5.48-ac just yet. I hope to push Linus the next
IDE updates pretty soon

