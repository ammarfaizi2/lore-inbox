Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132330AbRDCRFA>; Tue, 3 Apr 2001 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDCREv>; Tue, 3 Apr 2001 13:04:51 -0400
Received: from [209.125.249.77] ([209.125.249.77]:20487 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S132316AbRDCREb>; Tue, 3 Apr 2001 13:04:31 -0400
Date: Tue, 3 Apr 2001 10:02:45 -0700
Message-Id: <200104031702.f33H2j105370@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        Andries.Brouwer@cwi.nl, torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <E14kU4P-0008Q3-00@the-village.bc.nu>
In-Reply-To: <200104031605.f33G5D604937@mobilix.atnf.CSIRO.AU>
	<E14kU4P-0008Q3-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > However, a large number of people run devfs on small to large systems,
> > and these "races" aren't causing problems. People tell me it's quite
> 
> They dont have users actively trying to exploit them. I don't
> consider it a big problem for development trees though. devfs has a
> maintainer at least

Agreed. If I were a sysadmin where I had users I didn't trust, then
I'd be worried. Actually, I'd simply not enable module autoloading.
In fact, I don't run autoloading because I don't like it personally.
And I'm lucky that I have users on my network that I feel I can
trust. Besides, I know where they live, or at least where they store
their data/theses :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
