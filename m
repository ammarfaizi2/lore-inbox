Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUKDErT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUKDErT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUKDErT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:47:19 -0500
Received: from mx.inch.com ([216.223.198.27]:8455 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S262060AbUKDErO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:47:14 -0500
Date: Wed, 3 Nov 2004 23:47:13 -0500 (EST)
From: John McGowan <jmcgowan@inch.com>
To: Dave Airlie <airlied@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9: i810 video
In-Reply-To: <21d7e99704110314156bb270de@mail.gmail.com>
Message-ID: <20041103234045.G92772@shell.inch.com>
References: <20041102215308.GA3579@localhost.localdomain> 
 <21d7e99704110313583cccde5f@mail.gmail.com>  <20041103170945.V81684@shell.inch.com>
 <21d7e99704110314156bb270de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Dave Airlie wrote:

> >
> > I tried compiling the kernel without the intel810 framebuffer support
> > and still, it seems that something writes all over video memory (I did not
> > try using the fbdev driver in Xorg when I was trying to get 2.6.9 working,
> > just its i180 driver).
>
> Disable the i810 fb and i810 drm and see does X start properly (I
> expect it does..)
> then just add the DRM and see does it run....

I am just a user. I have no idea of what you are talking.
All I do is use "X" (xorg-x11, version 6.8.1). kernel compiled
without framebuffer support. Well it was. I got rid of kernel 2.6.9.
Back to kernel 2.6.7. Dialup. Another two hours to download 2.6.9
again. Another few hours to recompile and test the kernel.

I am no programmer. What is drm? How does the i810 driver in
xorg work? I have no idea.

> What chipset have you got?

An HP 7850 - various motherboards used ... this one has an
e-machine motherboard. Bios has no controls for the video
chip. Does FW82810E sound line the chipset? It is mentioned
somewhere in the motherboard doc I found on some site (not HP's
so it may or may not be correct).


Regards from:

    John McGowan  |  jmcgowan@inch.com                [Internet Channel]
                  |  jmcgowan@coin.org                [COIN]
    --------------+-----------------------------------------------------
