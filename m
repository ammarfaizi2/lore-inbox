Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281576AbRKMKaI>; Tue, 13 Nov 2001 05:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281583AbRKMK35>; Tue, 13 Nov 2001 05:29:57 -0500
Received: from mail128.mail.bellsouth.net ([205.152.58.88]:1751 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281578AbRKMK3o>; Tue, 13 Nov 2001 05:29:44 -0500
Message-ID: <3BF0F603.925167E3@mandrakesoft.com>
Date: Tue, 13 Nov 2001 05:29:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <E163aNp-0000cm-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > If and when I step down as maintainer (if I do so, I'll publically
> > pass the baton to the new maintainer), the new maintainer can indent
> > to their preference. Until that time, *I'm* the maintainer, and *I*
> > need to be able to read the code efficiently. It's the part of the
> > kernel I spend the most time in, after all.
> 
> I wasnt aware mtrr.c had an active maintainer.

According to changelog nothing substantive since March 1999.


> > "He who writes the code gets to choose".
> 
> How about he who has to decipher the whole mess to add things...

At least one person actually Lindent's mtrr.c, modifies, tests, and then
backports changes into un-Lindent'd mtrr.c.  Ug.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

