Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132763AbRDEVOL>; Thu, 5 Apr 2001 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132979AbRDEVOB>; Thu, 5 Apr 2001 17:14:01 -0400
Received: from camelot.student.liu.se ([130.236.230.77]:31361 "EHLO
	mail.student.liu.se") by vger.kernel.org with ESMTP
	id <S132763AbRDEVNv>; Thu, 5 Apr 2001 17:13:51 -0400
Date: Thu, 5 Apr 2001 23:13:02 +0200 (CEST)
From: Erik Gustavsson <cyrano@algonet.se>
To: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
cc: mmcclell@bigfoot.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ov511 problem
In-Reply-To: <Pine.LNX.4.21.0104051625170.8028-100000@pc-astro.spm.univ-rennes1.fr>
Message-ID: <Pine.LNX.4.21.0104052311590.2324-100000@lillan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Thomas Speck wrote:

IIRC the driver doesn't support compression, and there is no way you can
get 640x480 uncompressed at 30 fps over USB...

/cyr

> 
> Hi
> 
> I am trying to get working a Spacec@m 300 (USB) by Trust. I tried this
> under 2.2.18 and 2.4.3. In order to get the camera detected I can use the
> usb-uhci or uhci module (the result is the same). The camera gets detected
> (some OV7610 gets probed - I don't know if this is the correct one) and
> after loading the ov511 module I get the picture of the camera displayed
> with xawt-3.38 (resolution 640x480 - the camera is able to this). 
> The problem I am running into is that the framerate is extremely slow
> (maybe 3 fps), however, from the specifications it should work with 30
> fps. My system is a Pentium II with 300 Mhz. Some Miro TV card with a
> BT848 chip works fine with the bttv driver. 
> Do you have any idea ? 
> If you need more info, just let me know. I am also willing to do some
> tests...
> 
> --
> Thomas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 

-----------------------------------------------------------------------
Holly: I was in love once -- a Sinclair ZX-81. People said, 
"No, Holly, she's not for you." She was cheap, she was stupid 
and she wouldn't load -- well, not for me, anyway.

