Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSINPGl>; Sat, 14 Sep 2002 11:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSINPGk>; Sat, 14 Sep 2002 11:06:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:1549 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S317331AbSINPGk>; Sat, 14 Sep 2002 11:06:40 -0400
Date: Sat, 14 Sep 2002 17:11:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Hans-Peter Jansen <hpj@urpla.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
Message-ID: <20020914151132.GB10510@atrey.karlin.mff.cuni.cz>
References: <200209141651.00974.hpj@urpla.net> <Pine.LNX.4.44L.0209141206270.1857-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209141206270.1857-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The question is: why is the VM not able to fulfill such a simple need in
> > a clean way?
> 
> No. The question is: "why does swsuspend need to stick its fingers
> into every other subsystem of the kernel, instead of trying to
> remain vaguely modular ?"

I'm not trying to stick swsusp fingers anywhere. It was suggested to
me to hack VM and I'm trying to avoid that.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
