Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265449AbRF1AMm>; Wed, 27 Jun 2001 20:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265450AbRF1AMc>; Wed, 27 Jun 2001 20:12:32 -0400
Received: from [209.234.73.40] ([209.234.73.40]:46858 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S265449AbRF1AMT>;
	Wed, 27 Jun 2001 20:12:19 -0400
Date: Wed, 27 Jun 2001 19:11:23 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: jesse@cats-chateau.net, linux-kernel@vger.kernel.org
Subject: Re: The Joy of Forking
Message-ID: <20010627191123.J8027@altus.drgw.net>
In-Reply-To: <01062422482200.18805@tabby> <200106250803.EAA20874@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106250803.EAA20874@smarty.smart.net>; from humbubba@smarty.smart.net on Mon, Jun 25, 2001 at 04:03:54AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 04:03:54AM -0400, Rick Hohensee wrote:

> > >	rtlinux by default
> > >	no SMP
> > >		SMP doesn't scale. If this fork comes, the smart maintainer
> > >		will take the non-SMP fork.
> > 
> > Depends on platform and bus. From reports, it seems to scale just fine on
> > non-intel systems.
> 
> Big expensive systems. Non-desktop systems. Non-end-user systems. And
> clustering will eat its lunch eventually anyway.

You don't get much more end-user than a $2500 Dual Processor Mac G4. 
(And as soon as you say $2500 is a lot of money, I can probably find a 
dual CPU PentiumIII system for < $1000)

We would be perfectly happy if you have the time and ability to maintain a 
fork that can do all of this, and those of us that have more than one CPU 
type will be perfectly happy to ignore it.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
