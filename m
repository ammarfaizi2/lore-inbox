Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319150AbSIDMOX>; Wed, 4 Sep 2002 08:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319151AbSIDMOW>; Wed, 4 Sep 2002 08:14:22 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:500 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319150AbSIDMOW>; Wed, 4 Sep 2002 08:14:22 -0400
Subject: Re: 2.4.18 & 2.4.19 IDE chipset clash? Promise PDC20267/SvrWks CSB5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Johnson <jeff@wsm.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1031109167.4925.38.camel@eljefe.wsm.com>
References: <1031109167.4925.38.camel@eljefe.wsm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 13:19:28 +0100
Message-Id: <1031141968.2788.111.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 04:12, Jeff Johnson wrote:
> SvrWks CSB5: IDE controller on PCI bus 00 dev 79
> PCI: Device 00:0f.1 not available because of resource collisions
> SvrWks CSB5: (ide_setup_pci_device:) Could not enable device.

You need a current -ac tree for this to work. Im working on getting all
the bits needed into Marcelo's tree to fix it without feeding him IDE
updates

