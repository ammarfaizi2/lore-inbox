Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311238AbSCLU7o>; Tue, 12 Mar 2002 15:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311343AbSCLU7e>; Tue, 12 Mar 2002 15:59:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4362 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S311238AbSCLU70>; Tue, 12 Mar 2002 15:59:26 -0500
Date: Tue, 12 Mar 2002 21:59:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: strange dmesg output on athlon notebook
Message-ID: <20020312205924.GE12156@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020310220056.GA189@elf.ucw.cz> <20020312215557.C30825@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312215557.C30825@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > And why it says  CPU: After vendor init
>  > twice? [This is 2.5.6-acpi...]
> 
>  SMP kernel ? 
>  We init the boot CPU twice on SMP iirc.

Unless I made mistake, it was UP kernel.
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
