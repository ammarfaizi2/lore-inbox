Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSIOTso>; Sun, 15 Sep 2002 15:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSIOTso>; Sun, 15 Sep 2002 15:48:44 -0400
Received: from [209.173.6.49] ([209.173.6.49]:2952 "EHLO comet.linuxguru.net")
	by vger.kernel.org with ESMTP id <S318222AbSIOTsn>;
	Sun, 15 Sep 2002 15:48:43 -0400
Date: Sun, 15 Sep 2002 15:53:28 -0400
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, jonathan@buzzard.org.uk, pavel@ucw.cz
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020915195328.GA60517@comet>
References: <20020909115956.GA23290@comet> <20020911112938.A25726@infradead.org> <20020915154248.GA3647@elf.ucw.cz> <20020915213009.A53847@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020915213009.A53847@ucw.cz>
User-Agent: Mutt/1.4i
From: James Blackwell <jblack@linuxguru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 09:30:09PM +0200, Vojtech Pavlik wrote:
> On Sun, Sep 15, 2002 at 05:42:48PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > You've just made the driver horribly racy on SMP or preempt
> > > systems..
> > 
> > Well, as long as toshiba does not make SMP notebooks, we are safe ;-).
> 
> ... or preempt. Which doesn't really depend on Toshiba.
> 

Does that mean my very first kernel patch, insignificant as it is, is
probably acceptable?

Should I resubmit it? I haven't tried 2.5.34 yet, and 2.5.33 had keyboard
problems that prevented me from using it.


-- 
GnuPG fingerprint AAE4 8C76 58DA 5902 761D  247A 8A55 DA73 0635 7400
James Blackwell  --  Director http://www.linuxguru.net
