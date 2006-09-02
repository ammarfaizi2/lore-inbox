Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWIBXP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWIBXP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 19:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWIBXP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 19:15:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58826 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751736AbWIBXP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 19:15:27 -0400
Date: Sun, 3 Sep 2006 01:15:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
Message-ID: <20060902231509.GC13031@elf.ucw.cz>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de> <20060831110436.995bdf93.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831110436.995bdf93.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hm, it looks rather like a personal preference.
> > IMHO, it's harder to read without space...
> 
> We have been tending toward not using space in cases like this
> (in my unscientific memory-based survey).
> 
> So, just this morning I have seen questions and opinions about
> the following that could (or could not) use more documentation
> or codification and I'm sure that we could easily find more,
> but do we want to codify Everything??
> 
> 
> 1.  Kconfig help text should be indented (it's not indented in the
> 	GFS2 patches)
> 
> 2.  if (!condition1)	/* no space between ! and condition1 */
> 
> 3.  don't use C99-style // comments
> 
> 4.  unsigned int bitfield :<nr_bits>;

Looks reasonable to me. Will you do the patch or should I ?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
VGER BF report: U 0.489855
