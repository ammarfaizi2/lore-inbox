Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318163AbSGPU6j>; Tue, 16 Jul 2002 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSGPU6i>; Tue, 16 Jul 2002 16:58:38 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:64241 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318163AbSGPU53>; Tue, 16 Jul 2002 16:57:29 -0400
Subject: Re: Tyan s2466 stability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kurt Garloff <kurt@garloff.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020716205113.GC23954@nbkurt.etpnet.phys.tue.nl>
References: <Pine.LNX.4.33.0207161020280.2603-100000@tyan.doghouse.com>
	<1026834468.2119.61.camel@irongate.swansea.linux.org.uk> 
	<20020716205113.GC23954@nbkurt.etpnet.phys.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Jul 2002 23:10:46 +0100
Message-Id: <1026857446.1688.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-16 at 21:51, Kurt Garloff wrote:
> > I've seen it with IDE burners too. I don't know what the cause is
> 
> Strange SMI stuff, maybe?
> Bugs with PCI arbitration that are recovered from but take time?
> 
> You've probably already looked into those, though.

I've read the errata but thats not given me any clues. The box is fast,
including PCI bandwidth measurements but neither PCI card or SCSI
streaming to tape or CD-R works well. The motherboard IDE works a treat
and the 64bit slots give me excellent performance (but thats a raid card
so I can't yet use it for tape)

