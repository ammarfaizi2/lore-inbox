Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWAEX6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWAEX6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWAEX6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:58:43 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:32870 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP id S932273AbWAEX6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:58:41 -0500
Date: Fri, 6 Jan 2006 01:56:02 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <1136504364.847.88.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0601060153440.27932@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de>  <20060103193736.GG3831@stusta.de>
  <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> 
 <mailman.1136368805.14661.linux-kernel2news@redhat.com> 
 <20060104030034.6b780485.zaitcev@redhat.com>  <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
  <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> 
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> 
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>  <s5hmziaird8.wl%tiwai@suse.de>
  <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504364.847.88.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Lee Revell wrote:

> On Fri, 2006-01-06 at 01:06 +0200, Hannu Savolainen wrote:
> > > - PCM with 3-bytes-packed 24bit formats
> > Applications have no reasons to use for this kind of stupid format so
> > OSS translates it to the usual 32 bit format on fly. In fact OSS API
> > does have support for this format. 
> 
> What about hardware that only understands this format?
There is no such hardware. Or is there?

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
