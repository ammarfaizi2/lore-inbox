Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269671AbRHMBjf>; Sun, 12 Aug 2001 21:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269672AbRHMBj2>; Sun, 12 Aug 2001 21:39:28 -0400
Received: from ool-18b899e0.dyn.optonline.net ([24.184.153.224]:51438 "EHLO
	bouncybouncy") by vger.kernel.org with ESMTP id <S269671AbRHMBjR>;
	Sun, 12 Aug 2001 21:39:17 -0400
Date: Sun, 12 Aug 2001 21:39:15 -0400
From: Justin A <justin@bouncybouncy.net>
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Message-ID: <20010812213915.A5747@bouncybouncy.net>
In-Reply-To: <20010812155520.A935@ulthar.internal.mclure.org> <Pine.LNX.4.33.0108121557060.2102-100000@penguin.transmeta.com> <20010812161544.A947@ulthar.internal.mclure.org> <3B772126.F23DB1D7@randomlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B772126.F23DB1D7@randomlogic.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sblive(!) driver in 2.4.7 may very well work, but it doesn't come
close to supporting all the features that the card has.  Whether or
not 2.5 is the place to implement those features is a whole other
matter...

-Justin

On Sun, Aug 12, 2001 at 05:36:54PM -0700, Paul G. Allen wrote:
> Call me dumb, but what was wrong with the SB Live! code in the 2.4.7
> trees? Mine works fine and has since I first installed RH 7.1 on this
> system. The only problem I had was when I compiled it into the kernel
> (instead of compiling as a module), sound would not work and I could not
> configure it with sndconfig.
> 
> PGA
> 
> -- 
> Paul G. Allen
> UNIX Admin II/Network Security
> Akamai Technologies, Inc.
> www.akamai.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
