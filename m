Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289775AbSBJVaz>; Sun, 10 Feb 2002 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSBJVap>; Sun, 10 Feb 2002 16:30:45 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:26890 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289767AbSBJVaY>;
	Sun, 10 Feb 2002 16:30:24 -0500
Date: Sat, 9 Feb 2002 23:23:58 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
Message-ID: <20020209222358.GA1589@elf.ucw.cz>
In-Reply-To: <20020208001831.A200@steel> <20020208003653.A28235@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208003653.A28235@suse.de>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception: 0000000000000004
>  > Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
>  > Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt
> 
>  Machine checks are indicative of hardware fault.
>  Overclocking, inadequate cooling and bad memory are the usual
> causes.

Maybe you should print something like

Machine Check Exception: .... (hardware problem!)

so that we get less reports like this?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
