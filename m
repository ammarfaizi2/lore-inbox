Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWAFPsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWAFPsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbWAFPsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:48:13 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:12629 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751517AbWAFPsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:48:11 -0500
Date: Fri, 6 Jan 2006 16:48:07 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Hannu Savolainen <hannu@opensound.com>, Lee Revell <rlrevell@joe-job.com>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060106154807.GK1610@harddisk-recovery.com>
References: <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de> <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504460.847.91.camel@mindpipe> <Pine.LNX.4.61.0601060156430.27932@zeus.compusonic.fi> <43BE86BE.3010203@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BE86BE.3010203@stesmi.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 04:03:26PM +0100, Stefan Smietanowski wrote:
> Hannu Savolainen wrote:
> > Having dmix working in user space doesn't prove that kernel level mixing 
> > is evil. This was the original topic.
> 
> Wasn't there a thread a few years ago (3-5?) about sound mixing in the
> kernel?
> 
> I've tried searching for it but have been unsuccessful so I could be
> remembering wrong.

  "The kernel is an arbitrator of resources it is not a shit bucket for
   solving other peoples incompetence." -- Alan Cox

Here's the post:

  http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.3/0324.html


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
