Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbUCQWR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbUCQWR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:17:27 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:32019 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262108AbUCQWRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:17:25 -0500
Date: Wed, 17 Mar 2004 22:17:23 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Oystein Haare <lkml-account@mazdaracing.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: RadeonFB
In-Reply-To: <1079366460.853.3.camel@dawn>
Message-ID: <Pine.LNX.4.44.0403172215240.19415-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any different in the dmesg output between each kernel version?


On Tue, 16 Mar 2004, Oystein Haare wrote:

> Hi!
> 
> I'm having some problems with radeon framebuffer and the newer kernels.
> I have a HP/Compaq nx7010 laptop computer, that is supposed to have a
> Radeon 9200 graphics board.
> 
> Now.. in 2.6.1, it seems to work ok. But in 2.6.4 it just flickers alot.
> Are there anyone else than me experiencing this problem? 
> 
> This is what it outputs:
> 
> radeonfb: Found Intel x86 BIOS ROM Image
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz,
> System=220.00 MHz
> Non-DDC laptop panel detected
> radeonfb: Monitor 1 type LCD found
> radeonfb: Monitor 2 type no found
> radeonfb: panel ID string: Samsung LTN150P1-L02    
> radeonfb: detected LVDS panel size from BIOS: 1400x1050
> radeondb: BIOS provided dividers will be used
> radeonfb: Assuming panel size 1400x1050
> radeonfb: Power Management enabled for Mobility chipsets
> radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
> 
> Could the flickering have something to do with the fact that the lcd
> panel on my laptop can only do 1280x800 resolution? Or doesn't the
> 1400x1050 have anything to do with resolution at all?
> 
> PS: Please CC replies to me as I am not on the list.
> 
> thanks 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

