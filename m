Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266062AbUAFX7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUAFX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:59:13 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:43281 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266062AbUAFX7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:59:09 -0500
Date: Tue, 6 Jan 2004 23:59:05 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Oops] 2.6.1-rc1-mm1 and Sisfb
In-Reply-To: <200401060225.56953.jorge78@inwind.it>
Message-ID: <Pine.LNX.4.44.0401062357360.22693-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I use XFree from debian experimental (4.3.0-0pre1v4) and now it appears more 
> smooth than with 2.4.23-ck1! (thanks a lot!!!)

Yeah!!!!!

> At system startup I always choose video=sisfb:1024x768x256 to show linux logo 
> but if I try to boot without it, all characters aren't displayed very well... 

Ug. I will have to try that.

> Glxgears shows me 250 Fps (exactly as 2.4), but when cpu (p4m 1.6 ghz) reachs 
> 100%, ALT-TAB switching between apps is not fluid like with 2.4...  
> Probably it's a scheduler issue...
> However, it's a great job!!!
> So, what about your patches in 2.6 mainline ?

Very soon.

> Ok ok ...  only another question... :)
> Do you have some news about DRI for my SiS chipset? 

That is strange. SiS has DRI support. In fact the driver in my tree 
supports alot more SiS chipsets.


> 
> glxinfo shows me:
> ------------------------------
> D998:/home/io# glxinfo
> name of display: :0.0
> Xlib:  extension "XFree86-DRI" missing on display ":0.0".
> display: :0  screen: 0
> direct rendering: No
> server glx vendor string: SGI
> server glx version string: 1.2
> server glx extensions:
> ....
> 
> TIA,
> 					Jorge
> PS: sorry for all lexical mistakes I made...
> 
> 

