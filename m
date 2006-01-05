Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752187AbWAEXj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbWAEXj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWAEXj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:39:27 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41942 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751437AbWAEXj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:39:26 -0500
Subject: Re: [OT] ALSA userspace API complexity
From: Lee Revell <rlrevell@joe-job.com>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>
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
Content-Type: text/plain
Date: Thu, 05 Jan 2006 18:39:23 -0500
Message-Id: <1136504364.847.88.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 01:06 +0200, Hannu Savolainen wrote:
> > - PCM with 3-bytes-packed 24bit formats
> Applications have no reasons to use for this kind of stupid format so
> OSS translates it to the usual 32 bit format on fly. In fact OSS API
> does have support for this format. 

What about hardware that only understands this format?

Lee

