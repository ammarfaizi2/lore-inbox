Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290454AbSA3Sr7>; Wed, 30 Jan 2002 13:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290338AbSA3Sqj>; Wed, 30 Jan 2002 13:46:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3844 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290347AbSA3SUS>; Wed, 30 Jan 2002 13:20:18 -0500
Subject: Re: [PATCH] KERN_INFO for devfs
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Wed, 30 Jan 2002 18:32:24 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vda@port.imtp.ilyichevsk.odessa.ua,
        tao@acc.umu.se (David Weinehall),
        brand@jupiter.cs.uni-dortmund.de (Horst von Brand),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201301804.g0UI4nQ13064@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Jan 30, 2002 11:04:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VzWy-00082i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd prefer if tree maintainers (that means you, Alan:-) don't apply
> devfs patches that didn't come from me. I've already posted a patch
> which cleans up *all* the remaining printk()'s. In fact, it's a pair
> of patches, one for 2.4.x and one for 2.5.x. That was yesterday. Today
> I'm still seeing this thread being beaten to death.

I'll apply stuff to my tree that looks sane and see what happens, if I know
there is an active maintainer I'll also replace it with newer stuff from
the mainstream and I won't submit it on to Marcelo.

So no worries, I'm not going to screw your patchsets to Marcelo up
