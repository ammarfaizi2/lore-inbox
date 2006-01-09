Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965364AbWAIAgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbWAIAgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965371AbWAIAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:36:22 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:23408 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP id S965364AbWAIAgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:36:20 -0500
Date: Mon, 9 Jan 2006 02:33:43 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Jaroslav Kysela <perex@suse.cz>
Cc: Olivier Galibert <galibert@pobox.com>,
       Martin Drab <drab@kepler.fjfi.cvut.cz>, Takashi Iwai <tiwai@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <Pine.LNX.4.61.0601081424560.10981@tm8103.perex-int.cz>
Message-ID: <Pine.LNX.4.61.0601090231260.32511@zeus.compusonic.fi>
References: <20060104030034.6b780485.zaitcev@redhat.com>
 <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl> <s5h8xtshzwk.wl%tiwai@suse.de>
 <20060108020335.GA26114@dspnet.fr.eu.org> <Pine.LNX.4.60.0601080317040.22583@kepler.fjfi.cvut.cz>
 <20060108132122.GB96834@dspnet.fr.eu.org> <Pine.LNX.4.61.0601081424560.10981@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, Jaroslav Kysela wrote:

> > - having a real kernel api for which you can make different libraries
> >   depending on the need of the users
> > 
> > - stop making a fundamentally unsecure shared library mandatory
> 
> ALSA kernel API is real and binary compatible. 
Less than an year ago you (or was it Takashi) told that the kernel API 
cannot be used or documented because it may be changed any time without 
notice.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
