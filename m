Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289260AbSA3PE4>; Wed, 30 Jan 2002 10:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSA3PEq>; Wed, 30 Jan 2002 10:04:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45073 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289230AbSA3PE3>; Wed, 30 Jan 2002 10:04:29 -0500
Subject: Re: [PATCH] KERN_INFO for devfs
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Wed, 30 Jan 2002 15:16:53 +0000 (GMT)
Cc: tao@acc.umu.se (David Weinehall),
        brand@jupiter.cs.uni-dortmund.de (Horst von Brand),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201301232.g0UCWmt10496@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Jan 30, 2002 02:32:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VwTl-0007VJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, but that may change (in theory, at least.) Consistency is a virtue.
> 
> I'll do this cleanup if my KERN_INFO patches will be accepted, at least some 
> of them. So far only Richard Gooch replied...

I ran some of them into 7ac1 but got rejects so I've dumped them out for
now. They mostly look completely sensible
