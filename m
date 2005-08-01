Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263214AbVHAHbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbVHAHbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVHAH2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:28:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51338 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262419AbVHAH2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:28:14 -0400
Date: Mon, 1 Aug 2005 09:28:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: James Bruce <bruce@andrew.cmu.edu>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050801072807.GN27580@elf.ucw.cz>
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050731232941.GG27580@elf.ucw.cz> <1122854036.13000.33.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122854036.13000.33.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'm pretty sure at least one distro will go with HZ<300 real soon now
> > > > ;-).
> > > > 
> > > 
> > > Any idea what their official recommendation for people running apps that
> > > require the 1ms sleep resolution is?  Something along the lines of "Get
> > > bent"?
> > 
> > So you busy wait for 1msec, big deal.
> 
> Which requires changing all those apps.  

...which you have to do anyway for 2.4 compatibility.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
