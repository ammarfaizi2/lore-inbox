Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135426AbRDZN45>; Thu, 26 Apr 2001 09:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135413AbRDZN4r>; Thu, 26 Apr 2001 09:56:47 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:53634 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S135426AbRDZN4j>;
	Thu, 26 Apr 2001 09:56:39 -0400
Date: Thu, 26 Apr 2001 09:56:20 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
To: Andi Kleen <ak@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <Pine.LNX.4.30.0104260948210.6474-100000@tiger>
Message-ID: <Pine.LNX.4.30.0104260955110.6474-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem is I didn't see those error message on 2.4.2 or 2.4.0, only on
2.4.3. That's the reason I posted the question here. Maybe I will try
2.4.4

Thanks all for you guys!

Alex

On Thu, 26 Apr 2001, Feng Xian wrote:

>
> Yes I am running nvidia module. i tried nv, X use less memory but nv
> doesn't give me the NV_GLX extension, xlock will crash for some 3d mode.
>
> Alex
>
> On Thu, 26 Apr 2001, Andi Kleen wrote:
>
> > On Thu, Apr 26, 2001 at 08:09:06AM -0400, Feng Xian wrote:
> > > It looks like the X consumes most of the memory (almost used up all the
> > > physical memory, more than 100M), it uses NVidia driver. I was also
> > > running pppoe but that took less memory.
> >
> > You're probably using the NVidia provided driver module, right?
> > Try it without it and the "nv" driver.
> >
> >
> > -Andi
> >
>
>

-- 
 Feng Xian
     .-.
     /v\    L   I   N   U   X
    // \\  >Phear the Penguin<
   /(   )\
    ^^-^^

