Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbVKCWYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVKCWYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVKCWYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:24:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57759 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751405AbVKCWYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:24:25 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <m3oe51zc2e.fsf@defiant.localdomain>
	 <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 22:54:24 +0000
Message-Id: <1131058464.18848.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 22:29 +0100, Bartlomiej Zolnierkiewicz wrote:
> Do you think that libata is currently so much better wrt to PATA
> hot-(un)plug support?

With the hot plug patches for SATA it certainly is. Mainstream it isn't.
Best is still 2.4-ac

> > Yes, I think it's similar to OSS-ALSA, WRT - you know, 6-months forward
> > notice etc :-)
> 
> Ain't going to happen...

I don't think this a six month project. Well no getting all the PCI
stuff sorted is a six month project. Knocking it into shape and cleaning
up corner cases and details is considerably more.

Still I've done atiixp, opt621 and it8172 this afternoon. 

Alan
