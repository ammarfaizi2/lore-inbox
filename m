Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUBVQUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbUBVQUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:20:08 -0500
Received: from gprs148-229.eurotel.cz ([160.218.148.229]:50560 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261690AbUBVQOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:14:18 -0500
Date: Sun, 22 Feb 2004 17:12:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.6.3-uc0 (MMU-less fixups)
Message-ID: <20040222161254.GA1371@elf.ucw.cz>
References: <40342BD5.9080105@snapgear.com> <20040219103900.GH17140@khan.acc.umu.se> <4034B2E5.1090505@snapgear.com> <20040219131317.GI17140@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219131317.GI17140@khan.acc.umu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > David Weinehall wrote:
> > >On Thu, Feb 19, 2004 at 01:21:57PM +1000, Greg Ungerer wrote:
> > >>An update of the uClinux (MMU-less) fixups against 2.6.3.
> > >>Nothing much new, just redone against 2.6.3.
> > >>
> > >>http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.3-uc0.patch.gz
> > >
> > >Any plans for a 2.6-version of the ARM-support?
> > 
> > Yes. There is some code available now, although it is not complete
> > and doesn't fully work yet. It really needs more cleaning up before
> > it will be interresting or useful to anyone.
> 
> Dang.  I wish I still had some arm-hardware to play with (no, I'm not
> gonna sacrifice my Tungsten E for uClinux-work...)

Tungsten is Palm-clone, right? So they are using ARMs there, but
unlike everyone other, mmu-less ARMs?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
