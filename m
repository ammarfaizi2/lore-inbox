Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269336AbRHFXzf>; Mon, 6 Aug 2001 19:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRHFXzZ>; Mon, 6 Aug 2001 19:55:25 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22148 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269336AbRHFXzI>; Mon, 6 Aug 2001 19:55:08 -0400
Date: Mon, 6 Aug 2001 17:55:27 -0600
Message-Id: <200108062355.f76NtRa26224@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <E15TuCC-00021i-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15TuCC-00021i-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > Linus: please don't apply.
> > Alan: I notice you've put Al's patch into 2.4.7-ac8. Please remove it.
> 
> I'll remove it when your preferred fixes are ready. Until then its
> better than leaving it broken.

OK, fair enough. When is your next merge with Linus scheduled? I'd
prefer to get a few races fixed before shipping a patch, but I can try
to plan for an earlier release if necessary.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
