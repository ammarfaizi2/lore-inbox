Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267836AbRHMT0g>; Mon, 13 Aug 2001 15:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRHMT02>; Mon, 13 Aug 2001 15:26:28 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:13565 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267836AbRHMT0X>; Mon, 13 Aug 2001 15:26:23 -0400
From: Josh McKinney <forming@home.com>
Date: Mon, 13 Aug 2001 14:26:09 -0500
To: Nicholas Knight <tegeran@home.com>, linux-kernel@vger.kernel.org
Subject: Re: strange gcc crashes...
Message-ID: <20010813142609.A5700@home.com>
Mail-Followup-To: josh, Nicholas Knight <tegeran@home.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15WGJY-000Ecx-00@f12.port.ru> <01081305560700.00343@c779218-a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01081305560700.00343@c779218-a>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >>     so it seems to me like kernel problem...
> > >
> > >why is that?  I've never seen a sig11 from production >code
> > >that wasn't caused by flakey ram.  in fact, your >descriptions
> > >are a perfect example of similar hardware problems.
> >
> Synthetic tests are never as good as a real good gcc run, I'd *never* 
> trust them over the indications given by attempting to compile the kernel 
> or something big like XFree86.

I agree.  I had my computer mildy overclocked for a little while.  Everything
ran just great, I could compile kernels, quake3 timedemo for two days, etc.  
All was well until I tried to compile gcc itself and I kept getting random
errors.  I finally opened up the case and bumped it back down, and like magic
it compiled just fine.  

So my advice would be to don't overclock.

Josh
