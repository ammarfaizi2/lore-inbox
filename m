Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWCaVxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWCaVxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCaVxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:53:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29828 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751336AbWCaVxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:53:18 -0500
Subject: Re: snd-nm256: hard lockup on every second module load after
	powerup
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christian Trefzer <ctrefzer@gmx.de>, Takashi Iwai <tiwai@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <20060331211240.GD22677@stusta.de>
References: <20060326054542.GA11961@hermes.uziel.local>
	 <s5hveu0chvy.wl%tiwai@suse.de> <1143500400.1792.314.camel@mindpipe>
	 <20060329144303.GA24146@hermes.uziel.local>
	 <20060331211240.GD22677@stusta.de>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 16:53:13 -0500
Message-Id: <1143841995.27146.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 23:12 +0200, Adrian Bunk wrote:
> > Actually, the changes in Linus' current git have fixed the hang for
> me.
> > Good job - thanks a lot, guys!
> > 
> > Kind regards,
> > Chris
> 
> Takashi, would it be possible getting the fixes for this hard lookup 
> into 2.6.16.2?
> 

Is a 225 line patch to fix a driver that's never worked appropriate for
-stable?

Lee



