Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281910AbRKUPrh>; Wed, 21 Nov 2001 10:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281905AbRKUPr2>; Wed, 21 Nov 2001 10:47:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26640 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281910AbRKUPrL>; Wed, 21 Nov 2001 10:47:11 -0500
Date: Wed, 21 Nov 2001 16:45:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Swsusp mailing list <swsusp@lister.fornax.hu>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Gabor Kuti <seasons@falcon.sch.bme.hu>
Subject: Re: swsusp for 2.4.14
Message-ID: <20011121164512.C31379@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011121001858.B183@elf.ucw.cz> <E166M8H-0003QH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E166M8H-0003QH-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Warning. This probably corrupts memory. (All previous versinos did,
> > just noone noticed becuase it needed 20+ suspend/resume cycles). This
> > is probably best version ever, but it still corrupts data.
> 
> Has anyone tried porting swsusp to user mode linux. That way you could
> actually "suspend" a copy, resume it in parallel with the original and
> compare the two memory images ?

I wanted to but uml seemed to crash even without swsusp's help :-(.

								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
