Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268062AbTBMPbu>; Thu, 13 Feb 2003 10:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268063AbTBMPbu>; Thu, 13 Feb 2003 10:31:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58122 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268062AbTBMPbt>; Thu, 13 Feb 2003 10:31:49 -0500
Date: Thu, 13 Feb 2003 16:41:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] S4bios support
Message-ID: <20030213154138.GC27708@atrey.karlin.mff.cuni.cz>
References: <20030211185406.GA25167@elf.ucw.cz> <Pine.LNX.4.33.0302131611020.7941-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302131611020.7941-100000@godzilla.axis.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > S4bios is easier to use [no possibility to boot into wrong kernel;
> > machine actually indicates it is sleeping, not powered down], has
> > nicer progress bars, etc... I'd like to see it in. Please apply,
> 
> May I ask what s4bios does compared to "just s4" ? Does the kernel still 
> dump its core to swap or what happens ?

Yes, kernel suspends into swap space. See documentation/swsusp.txt for
details... You might want to add some details ;-).
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
