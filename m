Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWAFSh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWAFSh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbWAFSh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:37:27 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35541 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932671AbWAFSh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:37:26 -0500
Subject: Re: [OT] ALSA userspace API complexity
From: Lee Revell <rlrevell@joe-job.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Hannu Savolainen <hannu@opensound.com>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43BE86BE.3010203@stesmi.com>
References: <20050726150837.GT3160@stusta.de>
	 <20060103193736.GG3831@stusta.de>
	 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
	 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
	 <20060104030034.6b780485.zaitcev@redhat.com>
	 <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
	 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
	 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
	 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
	 <s5hmziaird8.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>
	 <1136504460.847.91.camel@mindpipe>
	 <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi>
	 <43BE86BE.3010203@stesmi.com>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 13:37:24 -0500
Message-Id: <1136572645.17979.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 16:03 +0100, Stefan Smietanowski wrote:
> I can't remember if it was about OSS, ALSA or anything else but I
> believe the conclusion was that sound mixing does NOT belong in the
> kernel and SHOULD be done in userspace.

Well, sound mixing really belongs in hardware, but that seems to be a
lost cause - vendors are way too cheap these days.

I can't believe they managed to hoodwink Windows gamers into accepting a
new generation of sound devices that make the CPU do the work the
hardware used to do...

Lee

