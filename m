Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272225AbRHWFTr>; Thu, 23 Aug 2001 01:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272226AbRHWFTi>; Thu, 23 Aug 2001 01:19:38 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:2979 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272225AbRHWFTc>; Thu, 23 Aug 2001 01:19:32 -0400
Date: Wed, 22 Aug 2001 23:19:45 -0600
Message-Id: <200108230519.f7N5JjG06014@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Luca Montecchiani <m.luca@iname.com>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [FAQ?] More ram=less performance (maximum cacheable RAM)
In-Reply-To: <3B8350D3.CDE749E1@iname.com>
In-Reply-To: <3B82B988.50DE308A@iname.com>
	<200108211957.f7LJvEt20846@vindaloo.ras.ucalgary.ca>
	<998430817.3139.41.camel@phantasy>
	<3B8350D3.CDE749E1@iname.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Montecchiani writes:
> Robert Love wrote:
> > 
> > It also has nothing to do with Linux.  Some motherboard's TAG RAM do not
> > allow for caching more than xMB.
> 
> I'm just proposing to update the FAQ to help people like me 
> that thinking to gain speed doubling the system ram have seen
> a severe performance drop for certain task like compiling the 
> kernel .
> 
> Answer : 
> It has nothing to do with Linux, maybe your motherboard's TAG Ram
> do not allow for caching more than xMB.

It's a useful entry, but I don't think it really belongs in the
linux-kernel mailing list FAQ. It belongs in some other
hardware-related document. Better to search for an appropriate one,
and get that updated as needed. I'm happy to add a link to it, though.

I just don't want the LKML FAQ turning into a bloated monster that
tries to answer all questions. The WWW is a *web*, not a central
repository, and works best if we keep it a web. Links Are Good[tm].

While I'm flattered you consider me (or at least the LKML FAQ) the
fount of all knowledge, I really would feel better if others shared in
the burden^Wglory.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
