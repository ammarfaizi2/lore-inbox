Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289273AbSBNAs6>; Wed, 13 Feb 2002 19:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289278AbSBNAss>; Wed, 13 Feb 2002 19:48:48 -0500
Received: from [62.46.129.105] ([62.46.129.105]:48769 "EHLO pitt.yi.org")
	by vger.kernel.org with ESMTP id <S289273AbSBNAsg>;
	Wed, 13 Feb 2002 19:48:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christoph Pittracher <pitt@gmx.at>
Organization: PITT
Message-Id: <200202140144.50805@pitt4u.2y.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel 2.2.20 RAM requirements
Date: Thu, 14 Feb 2002 01:48:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16b5w1-0006Js-00@the-village.bc.nu>
In-Reply-To: <E16b5w1-0006Js-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 February 2002 21:23, Alan Cox wrote:
> > I wanted to boot kernel version 2.2.20 on my old Pentium 75Mhz
> > system with 16MB RAM. After "uncompressing linux" i get a: "Out Of
> > Memory -- System halted".
> > Kernel version 2.2.19 works without problems (same kernel
> > configuration). I didn't tried 2.4 kernels yet, but I wonder that
> > 2.2.20 needs so much memory?
> It doesn't. What boot loader are you using ?

LILO version 21.5-1 beta
from Debian 2.2r5.

best regards,
Christoph
