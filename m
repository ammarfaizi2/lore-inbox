Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbRGKI4q>; Wed, 11 Jul 2001 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbRGKI4g>; Wed, 11 Jul 2001 04:56:36 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:50953 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S267237AbRGKI4Y>;
	Wed, 11 Jul 2001 04:56:24 -0400
To: antoniopagliaro@tin.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon Thunderbird, Abit KT7 Raid, Kernel 2.4: DESKTOP FROZEN!
In-Reply-To: <01071023392004.02550@lila.localdomain>
In-Reply-To: <01071023392004.02550@lila.localdomain>
Message-Id: <E15KFnD-0001Sk-00@kasba.alcove-fr>
From: Jean Schurger <jk24@alcove.fr>
Date: Wed, 11 Jul 2001 10:56:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In alcove.lists.linux.kernel, you wrote:
> 
> My box: Athlon Thunderbird 900 MHz, MotherboardAbit KT7 Raid, 
> Kernel 2.4 (the one that comes with Red Hat 7.1 no updates) 
> 
> I get apparently random desktop freezing.
> 
> Last time:
> 
> I was just doing nothing so the screensaver
> was on when I noticed the screen was frozen. Nor the keyboard
> neither the mouse worked. No combination of CTRL-ALT keys.
> Only choice left: reset. I did it.  When it booted again I got a
> 
> Kernel Panic: Attempted to kill the idle task
> In idle: not syncing.
> 
> (by the way: what is the SysRq magic or something similar?
> Does it help? Which keys??)
> 
> This time I had to unplug the computer. After 5 minutes I tried again.
> In many trials I got hundreds of errors. These:
> 

Try to compile a kernel without the Athlon optimization (just K6...).

-- 
Jean.Schurger@fr.alcove.com - Open Source Software Engineer
Alcove - (+33) 1 49 22 68 00 - http://www.alcove.com
Schurger.org - jk24@schurger.org - http://www.schurger.org
