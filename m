Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263306AbSJCMnG>; Thu, 3 Oct 2002 08:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263307AbSJCMnG>; Thu, 3 Oct 2002 08:43:06 -0400
Received: from im1.mail.tds.net ([216.170.230.91]:8640 "EHLO im1.sec.tds.net")
	by vger.kernel.org with ESMTP id <S263306AbSJCMnF>;
	Thu, 3 Oct 2002 08:43:05 -0400
Date: Thu, 3 Oct 2002 08:48:19 -0400 (EDT)
From: Jon Portnoy <portnoy@tellink.net>
X-X-Sender: portnoy@localhost.localdomain
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40: AT keyboard input problem
In-Reply-To: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0210030847200.24905-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reproduced with an AT keyboard here, too.


On Thu, 3 Oct 2002, Tobias Ringstrom wrote:

[snip]
> 
> If I press and hold my left Alt key, press and release the right AltGr
> key, and then release the left Alt key, I get one of the following
> messages in dmesg:
> 
> atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
[snip]
> 
> The left Alt key is now stuck until I press and release it again.
> 
> The same thing happens for a few other combinations as well. I happens 
> both in X and in the console.
> 
> Please let me know if you need more info.
> 
> /Tobias

