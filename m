Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbWEaVmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbWEaVmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWEaVmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:42:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:6601 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965175AbWEaVmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:42:46 -0400
Date: Wed, 31 May 2006 23:42:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "D. Hazelton" <dhazelton@enter.net>
cc: Dave Airlie <airlied@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <200605282316.50916.dhazelton@enter.net>
Message-ID: <Pine.LNX.4.61.0605312341240.30170@yvahk01.tjqt.qr>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
 <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
 <200605282316.50916.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> c) Lots of distros don't use fbdev drivers, forcing this on them to
>> use drm isn't an option.
>
>what distro's? The only ones that don't are either the ones that hold the 
>users hand or the ones where the user is meant to be able to quickly change 
>and modify the system.
>
As long as I can continue to use 80x25 or any of the "pure text modes"
(vga=scan boot option says more) without loading any FB/DRM, I am satisfied :)



Jan Engelhardt
-- 
