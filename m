Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUHPHtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUHPHtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 03:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHPHtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 03:49:49 -0400
Received: from gprs214-198.eurotel.cz ([160.218.214.198]:42885 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267482AbUHPHtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 03:49:40 -0400
Date: Mon, 16 Aug 2004 09:49:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jakub Vana <gugux@centrum.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 - Realmode BIOS and Code calling module
Message-ID: <20040816074924.GB25783@elf.ucw.cz>
References: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have written Linux Kernel module that allows you to call BIOS
> interupts, Far services or your own code. It's working on x86
> machines with PAE or not PAE enabled(up to 4GB or up to 64GB). It's
> tested on 2.4.26 and 2.6.7 kernel on P4 machine. I think there is
> not problem to work on others. Now, I'm preparing DOCs and Demos.

How is it better from code Ole Rohne has?

> I wrote the module especialy for changing the VESAFB videomode, but It is usable anywhere the BIOS is neaded.
> 
> I'm writing you to know this code exists and to ask you for help to add this code to official Kernel distribution.

Hmm, perhaps you should add at least pointer to the code there.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
