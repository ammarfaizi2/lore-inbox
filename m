Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129639AbQLHSHU>; Fri, 8 Dec 2000 13:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131696AbQLHSHK>; Fri, 8 Dec 2000 13:07:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:32007 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129639AbQLHSGy>; Fri, 8 Dec 2000 13:06:54 -0500
Date: Fri, 8 Dec 2000 11:31:58 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001208113158.A4730@vger.timpanogas.org>
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <E144O01-0003v7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E144O01-0003v7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 08, 2000 at 01:55:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 01:55:43PM +0000, Alan Cox wrote:
> > somewhere in the thousands.  Is NTFS write stable enough now in 2.4 to
> > fix these problems, if so, can we DISABLE by REMOVING write code in the
> 
> It says DANGEROUS in big letters on the configuration option. We are now
> down to the level of people who don't understand 'smoking kills you' in big
> letters on packaging, and people using very old trees that merely warned you
> that it was a very bad idea

I agree that if you give a mentally unbalanced person a firearm, they might 
shoot themselves with it.  I am suggesting we take away their firearm.  Write
support for NTFS is useful for migrating from Linux to NT, R/O support is 
useful for migrating NT to Linux.  We won't be giving anything up.  I think
just putting in a nastier warning message would suffice.

Jeff


> 
> Alan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
