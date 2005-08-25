Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVHYOeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVHYOeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVHYOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:34:24 -0400
Received: from witte.sonytel.be ([80.88.33.193]:30875 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751240AbVHYOeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:34:23 -0400
Date: Thu, 25 Aug 2005 16:33:43 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] (18/22) task_thread_info - part 2/4
In-Reply-To: <Pine.LNX.4.61.0508251610441.3728@scrub.home>
Message-ID: <Pine.LNX.4.62.0508251628500.28348@numbat.sonytel.be>
References: <E1E8AEh-0005eT-NP@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.61.0508251107500.24552@scrub.home>
 <20050825130738.GQ9322@parcelfarce.linux.theplanet.co.uk>
 <20050825135933.GA14448@infradead.org> <Pine.LNX.4.61.0508251610441.3728@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Roman Zippel wrote:
> On Thu, 25 Aug 2005, Christoph Hellwig wrote:
> > Yup.  Let's get m68k into buildable shape for 2.6.13 with Al's minimal
> > patches, and if you have further improvements over that submit them as
> > split up patches through the usual channels.  Having all architectures
> > actually build and work from mainline is really important to have
> > useful kernel package in distributions.
> 
> No, there has been no discussion of these patches, so there is no point in 
> doing this a few days before 2.6.13. Can we please do this properly for 
> 2.6.14?

Notwithstanding the actual content of the patches, I agree there's indeed no
need to hurry (unless Christoph's unifying Debian kernel hat is weighting a
lot).

A few months of delay for 2.6.14 is almost unnoticeable on the Linux/m68k
timescale anyway ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
