Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSABVU4>; Wed, 2 Jan 2002 16:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284335AbSABVUB>; Wed, 2 Jan 2002 16:20:01 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43217 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284282AbSABVS6>; Wed, 2 Jan 2002 16:18:58 -0500
Date: Wed, 2 Jan 2002 14:18:34 -0700
Message-Id: <200201022118.g02LIYN28610@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nahshon@actcom.co.il, linux-kernel@vger.kernel.org
Subject: Re: SCSI host numbers?
In-Reply-To: <E16LsWL-0005Rg-00@the-village.bc.nu>
In-Reply-To: <200201021931.g02JV1R27294@vindaloo.ras.ucalgary.ca>
	<E16LsWL-0005Rg-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Comments? Got a suggestion for which file the generic function should
> > go into? I figure on stripping the leading "devfs_" part of the
> > function names.
> 
> Sounds sensible to me. I guess it belongs in lib/ somewhere ?

I was thinking perhaps lib/unique.c

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
