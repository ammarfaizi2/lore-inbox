Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRCJU0T>; Sat, 10 Mar 2001 15:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131149AbRCJU0K>; Sat, 10 Mar 2001 15:26:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129460AbRCJU0D>; Sat, 10 Mar 2001 15:26:03 -0500
Subject: Re: [PATCH]: allow notsc option for buggy cpus
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Sat, 10 Mar 2001 20:28:37 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        anton@linuxcare.com.au (Anton Blanchard), linux-kernel@vger.kernel.org
In-Reply-To: <20010310222146.L23336@mea-ext.zmailer.org> from "Matti Aarnio" at Mar 10, 2001 10:21:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bpyi-0007KN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Intel are being remarkably reluctant on the documentation front.  We have
> > the AMD speed change docs, but the intel ones (chipset not cpu based
> > primarily) don't seem to be publically available. In fact the 815M manual
> > looks like someone quite pointedly went through and removed the relevant
> > material before publication
> 
> 	Isn't that one of the things that the ACPI is for ?
> 	Aren't we supposed to use  ACPI  for this ?

If you want to trust a large in kernel interpreter of binary only interpreter
code from a BIOS vendor be my guest. Im also not sure ACPI will give us the
notifications we need, even in the cases where it actually works.

Alan

