Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWIFV04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWIFV04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 17:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWIFV04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 17:26:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48533 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751268AbWIFV0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 17:26:55 -0400
Date: Wed, 6 Sep 2006 15:51:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
Message-ID: <20060906135140.GC11405@elf.ucw.cz>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de> <20060831110436.995bdf93.rdunlap@xenotime.net> <20060902231509.GC13031@elf.ucw.cz> <20060902213046.dd9bf569.rdunlap@xenotime.net> <20060905080813.GE1958@elf.ucw.cz> <20060905084352.1ced999e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905084352.1ced999e.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +comment out unused code.
> > +
> 
> Is there an acceptable way to leave source code in a file but
> render it unused?  Like #if 0/#endif or #if BOGUS_SYMBOL/#endif ?

I'd say "no way is acceptable, but #if 0/#endif is least evil" :-).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
