Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTBCTFc>; Mon, 3 Feb 2003 14:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTBCTFc>; Mon, 3 Feb 2003 14:05:32 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:44631 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S266983AbTBCTFb>; Mon, 3 Feb 2003 14:05:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jos Hulzink <josh@stack.nl>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] 2.5.59 morse code panics
Date: Mon, 3 Feb 2003 20:14:57 +0100
User-Agent: KMail/1.4.3
References: <Pine.LNX.3.96.1030202104101.22592E-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030202104101.22592E-100000@gatekeeper.tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302032014.57518.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 February 2003 16:42, Bill Davidsen wrote:
> On Fri, 31 Jan 2003, John Bradford wrote:
> > Well, there are typically *three* keyboard LEDs...  Why not use one
> > the middle one for morse, and outside two for plain blinking?
>
> Sure, alternating on/off between the outside LEDs at a rate of about
> 1/sec, like the warning lights on a railroad crossing (in the USA).

<nonsense>
As long as this doesn't mean a 50.000 kilo locomotive will ride over my 
keyboard, it is fine with me.

Oh, and I don't want to destroy the American dream, but blinking lights on 
railroad crossings even exist in the poorest countries in Africa... Or do the 
Americans even have a patent on the blinking speed ? :-P

Sidenote: you can't speak of "the middle", the LED ordering is free :) At 
least here in Europe...
</nonsense>

Besides, I'd like to see some beeps (not too annoying please) besides the 
blinking. Sometimes while debugging KGI I don't even notice the kernel 
entered kdb (also blinking LEDs, and kdb shows up on a remote terminal). 
Also: servers will usually have keyboard switches, making the blinks unnoted. 
But I assume that has been said before.

Jos
