Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752018AbWICE1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWICE1T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 00:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWICE1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 00:27:18 -0400
Received: from xenotime.net ([66.160.160.81]:63907 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752018AbWICE1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 00:27:18 -0400
Date: Sat, 2 Sep 2006 21:30:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, pshou@realtek.com.tw
Subject: Re: CodingStyle (was: Re: sound/pci/hda/intel_hda: small cleanups)
Message-Id: <20060902213046.dd9bf569.rdunlap@xenotime.net>
In-Reply-To: <20060902231509.GC13031@elf.ucw.cz>
References: <20060831123706.GC3923@elf.ucw.cz>
	<s5h8xl52h52.wl%tiwai@suse.de>
	<20060831110436.995bdf93.rdunlap@xenotime.net>
	<20060902231509.GC13031@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Sep 2006 01:15:10 +0200 Pavel Machek wrote:

> Hi!
> 
> > > Hm, it looks rather like a personal preference.
> > > IMHO, it's harder to read without space...
> > 
> > We have been tending toward not using space in cases like this
> > (in my unscientific memory-based survey).
> > 
> > So, just this morning I have seen questions and opinions about
> > the following that could (or could not) use more documentation
> > or codification and I'm sure that we could easily find more,
> > but do we want to codify Everything??
> > 
> > 
> > 1.  Kconfig help text should be indented (it's not indented in the
> > 	GFS2 patches)
> > 
> > 2.  if (!condition1)	/* no space between ! and condition1 */
> > 
> > 3.  don't use C99-style // comments
> > 
> > 4.  unsigned int bitfield :<nr_bits>;
> 
> Looks reasonable to me. Will you do the patch or should I ?

Please (you) go ahead with it.

Thanks,
---
~Randy

-- 
VGER BF report: U 0.5
