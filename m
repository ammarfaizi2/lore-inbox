Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319152AbSH2NG2>; Thu, 29 Aug 2002 09:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319153AbSH2NG2>; Thu, 29 Aug 2002 09:06:28 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:42490
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319152AbSH2NG1>; Thu, 29 Aug 2002 09:06:27 -0400
Subject: Re: i845mp support: 82845 (Brookdale) 82801BAM/CAM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kerl, Andreas" <andreas.kerl@dts.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2BB73D0BED687449BA36B05B1C5FA9F439241A@exchange2000.dts.intra>
References: <2BB73D0BED687449BA36B05B1C5FA9F439241A@exchange2000.dts.intra>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 11:31:07 +0100
Message-Id: <1030617147.7190.103.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 08:44, Kerl, Andreas wrote:
> Hi,
> when will this chipset support be merged into standard kernel (dma works
> with the ac tree)?

Eventually. I have to get Marcelo all the pci updates and a couple of
pci bug fixes before I can feed him the pci_enable_bars ide fix. He has
some of the bits now

