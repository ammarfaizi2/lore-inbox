Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292708AbSCSVJW>; Tue, 19 Mar 2002 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292700AbSCSVJM>; Tue, 19 Mar 2002 16:09:12 -0500
Received: from [195.39.17.254] ([195.39.17.254]:56194 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S292708AbSCSVI4>;
	Tue, 19 Mar 2002 16:08:56 -0500
Date: Tue, 19 Mar 2002 14:25:24 +0000
From: Pavel Machek <pavel@suse.cz>
To: David Golden <david.golden@oceanfree.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Message-ID: <20020319142523.A55@toy.ucw.cz>
In-Reply-To: <E16le8P-00028c-00@the-village.bc.nu> <02031500124202.02088@golden1.goldens.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > We've got one. Its 0x80. It works everywhere with only marginal non
> > problematic side effects
> 
> I've always liked POST cards.  They could hypothetically be useful
> for kernel development,too  - who hasn't wanted a low-level 
> single-asm-instruction status output from a running system at one time or 
> another , independent of any other output mechanisms?
> 
> OK it's a single byte, but it's still nice...  That's two whole hex digits!
> DE... AD...  BE... EF... !

Use 0x378 for that, works equally well.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

