Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWF0JPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWF0JPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWF0JPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:15:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35257 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161060AbWF0JPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:15:24 -0400
Date: Tue, 27 Jun 2006 11:15:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Charles Majola <chmj@rootcore.co.za>
Cc: Ben Martel <benm@symmetric.co.nz>, Patrick McFarland <diablod3@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, stephen@blacksapphire.com,
       kernel list <linux-kernel@vger.kernel.org>, radek.stangel@gmsil.com
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
Message-ID: <20060627091509.GD29199@elf.ucw.cz>
References: <20060616094516.GA3432@elf.ucw.cz> <449BEABD.5010305@rootcore.co.za> <1151070837.4549.18.camel@localhost.localdomain> <200606270437.59454.diablod3@gmail.com> <44A0F4CC.2000606@symmetric.co.nz> <44A0F617.6050106@rootcore.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A0F617.6050106@rootcore.co.za>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I have had a look at the changes to the 2.6.1{6,7} kernel to do with 
> >the buffering and I think that this driver will benefit greatly from 
> >the changes away from the flip/flop scheme.
> >
> >When Steve and I originally wrote the driver it always seemed to be 
> >limited throughput wise, due to the inefficient char handling it did.
> >
> >Good luck in the 'hacking it for 2.6.1{6,7} department' let me know if 
> >I can help at all :)
> >
> >BTW: Can someone tell me the version that you are changing - I may 
> >have a later version that fixes a problem with the V2 PCMCIA cards 
> >from IPWireless/T-Mobile.
> >
> 
> I have version 1.0.1 - 28 Mar 2004, working with the 2.6.15 kernel, with 
> some minor changes I made.

Can you post it somewhere? Radek was trying to make it work with
2.6.16...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
