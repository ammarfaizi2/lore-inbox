Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282236AbRKWUgy>; Fri, 23 Nov 2001 15:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282235AbRKWUge>; Fri, 23 Nov 2001 15:36:34 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:50706 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282229AbRKWUg1>; Fri, 23 Nov 2001 15:36:27 -0500
Message-ID: <3BFEB300.680A55A7@zip.com.au>
Date: Fri, 23 Nov 2001 12:35:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Daniel Phillips <phillips@bonn-fries.net>, war <war@starband.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <3BFEAE22.1CE8DE5B@zip.com.au>,
		<5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
	 <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
	 <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
	 <E167M0I-0002PD-00@starship.berlin> <5.1.0.14.2.20011123201824.05610ec0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Hi Andrew,
> 
> At 20:14 23/11/01, Andrew Morton wrote:
> >Daniel Phillips wrote:
> > >
> > > If there is a performance hit, it's not enough to worry about.
> >
> >except egcs-1.1.2 (2.91.6) compiles stuff at almost twice the speed
> >of gcc3.  The person who breaks egcs-1.1.2 for kernel builds owes
> >me a quad Xeon, thanks very much.
> 
> Have you read the current Documentation/Changes? It says "the 2.5 tree is
> likely to drop egcs-1.1.2 workarounds". Whoever wrote that seems to be
> wanting to break it in the near future...

Well that's great news.  To whom do I send my shipping address?

Actually, I have negligible interest in working on something which
won't be useful to real people for three years, so that works out,
doesn't it?

-
