Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWAJNpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWAJNpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWAJNpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:45:12 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:7541 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1750822AbWAJNpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:45:10 -0500
Date: Tue, 10 Jan 2006 15:42:33 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Jaroslav Kysela <perex@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.LNX.4.61.0601101040430.10330@tm8103.perex-int.cz>
Message-ID: <Pine.LNX.4.61.0601101520360.24146@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de>  <20060103193736.GG3831@stusta.de>
  <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> 
 <mailman.1136368805.14661.linux-kernel2news@redhat.com> 
 <20060104030034.6b780485.zaitcev@redhat.com>  <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
  <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> 
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> 
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>  <s5hmziaird8.wl%tiwai@suse.de>
  <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504460.847.91.camel@mindpipe>
 <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi>
 <Pine.LNX.4.61.0601101040430.10330@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Jaroslav Kysela wrote:

> Overloading interrupt handlers with extra things is evil (and I bet you're 
> mixing samples in the interrupt handler). Even the network stack uses 
> interrupts only for DMA management and not for any extra operations.
You mean it's evil because nobody else is doing it? Then it must be  
evil or rather voodoo.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
