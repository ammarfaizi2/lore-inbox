Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275469AbRIZSsC>; Wed, 26 Sep 2001 14:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275467AbRIZSrw>; Wed, 26 Sep 2001 14:47:52 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43488 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S275466AbRIZSrp>; Wed, 26 Sep 2001 14:47:45 -0400
Date: Wed, 26 Sep 2001 12:48:01 -0600
Message-Id: <200109261848.f8QIm1q09567@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <20010926142411.G8223@redhat.com>
In-Reply-To: <E15mHjL-0000t8-00@the-village.bc.nu>
	<Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com>
	<200109261743.f8QHhPU08423@vindaloo.ras.ucalgary.ca>
	<20010926142411.G8223@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise writes:
> On Wed, Sep 26, 2001 at 11:43:25AM -0600, Richard Gooch wrote:
> > BTW: your code had horrible control-M's on each line. So the compiler
> > choked (with a less-than-helpful error message). Of course, cat t.c
> > showed nothing amiss. Fortunately emacs doesn't hide information.
> 
> You must be using some kind of broken MUA -- neither mutt nor pine 
> resulted in anything with a trace of 0x0d in it.

My MUA doesn't know about MIME at all (part of the reason I hate
MIME). I save the message to a file and run uudeview 0.5pl13.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
