Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSFFSbL>; Thu, 6 Jun 2002 14:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSFFSae>; Thu, 6 Jun 2002 14:30:34 -0400
Received: from [195.39.17.254] ([195.39.17.254]:45216 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317047AbSFFS2n>;
	Thu, 6 Jun 2002 14:28:43 -0400
Date: Sun, 2 Jun 2002 05:16:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Message-ID: <20020602051633.D121@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <200206031318.09634.bhards@bigpond.net.au> <20020604140920.B36@toy.ucw.cz> <200206050805.21360.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > Please don't tell people about sysrq-D, I'm going to kill that. OTOH
> > convient way is echo 4 > /proc/acpi/sleep -- that is if you have ACPI
> > enabled.
> Extract from the patch:
> -  You may suspend your machine by either pressing Sysrq-d or with
> <snip>
> +  require APM. You may suspend your machine by either pressing 
> +  Sysrq-d or with 'swsusp' or 'shutdown -z <time>' (patch for 
> 
> So it is in the original. When you kill the functionality, update the doco.

Yep, I should do that.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

