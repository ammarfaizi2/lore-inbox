Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263450AbRFAL3H>; Fri, 1 Jun 2001 07:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263449AbRFAL25>; Fri, 1 Jun 2001 07:28:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15246 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263450AbRFAL2t>;
	Fri, 1 Jun 2001 07:28:49 -0400
Date: Fri, 1 Jun 2001 07:28:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac6
In-Reply-To: <20010601120105.A1356@lightning.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0106010725530.20420-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Jun 2001, Alan Cox wrote:

> o	Fix the cs46xx right this time			(me)
> o	Further FATfs cleanup				(OGAWA Hirofumi)
> o	ISDN PPP code cleanup, cvs tag update		(Kai Germaschewski)
> o	Large amount of UFS file system cleanup		(Al Viro)

Tt's still broken on r/w. R/o should be OK now.

> o	Move UFS file system to use dcache for metadata	(Al Viro)

What???

