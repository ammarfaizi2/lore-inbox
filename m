Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSE2WmZ>; Wed, 29 May 2002 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSE2WmY>; Wed, 29 May 2002 18:42:24 -0400
Received: from www.transvirtual.com ([206.14.214.140]:27667 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315616AbSE2WmX>; Wed, 29 May 2002 18:42:23 -0400
Date: Wed, 29 May 2002 15:42:08 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Melchior FRANZ <a8603365@unet.univie.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19: tdfxfb broken
In-Reply-To: <200205292243.11106@pflug3.gphy.univie.ac.at>
Message-ID: <Pine.LNX.4.10.10205291539010.19493-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm using the framebuffer on a 3dfx V3-3000 using the tdfxfb driver and
> the following setup:
> 
>   append = "3 video=tdfx:1280x1024-8,nomtrr,font:SUN12x22"
> 
> This worked well for all 2.4.* kernels and all working 2.5.* kernels
> so far. It doesn't work with 2.5.19. The screen remains all black
> without any text being shown. Just the logo is shown in its original size
> at the right position, but in wrong colors (e.g. the normally black
> background around Tux is blue).

I noticed that when I tried the above line. I have a patch coming. Give me
a few minutes.



