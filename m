Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264770AbSKEKad>; Tue, 5 Nov 2002 05:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbSKEKad>; Tue, 5 Nov 2002 05:30:33 -0500
Received: from 24-205-160-225.riv-eres.charterpipeline.net ([24.205.160.225]:28924
	"EHLO kubus.grambling.net") by vger.kernel.org with ESMTP
	id <S264770AbSKEKab>; Tue, 5 Nov 2002 05:30:31 -0500
Subject: Re: Problem with USB-OHCI (2.4.20-pre10-ac2) and Sony Picturebook
	PCG-C1MHP
From: Jacek Pliszka <pliszka@physics.ucr.edu>
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021105103602.7c1282fa.Manuel.Serrano@sophia.inria.fr>
References: <20021105103602.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Nov 2002 01:53:15 -0800
Message-Id: <1036489995.15137.136.camel@kubus.grambling.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 01:38, Manuel Serrano wrote:
> Hello there,
> 
> Here is the description of my third problems with my Sony Picturebook 
> PCG-C1MHP computer. I'm sorry to annoy everybody with my problems. I'm
> afraid that this bug report is not even the last one...

There is too much in it.

You got ALI chipset and there is a lot of problems with ALI chipsets
- I got a serious one (no PCMCIA) myself.

I suggest you to search the archive for 

ALI and IRQ

There is a patch in pci-irq.c for broken HP Pavilion BIOS (ALI chipset
as well) - if your problem is similar - may work for you.

good luck,

Jacek


