Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWC0XAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWC0XAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWC0XAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:00:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47332 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750829AbWC0XAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:00:03 -0500
Subject: Re: snd-nm256: hard lockup on every second module load after
	powerup
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christian Trefzer <ctrefzer@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <s5hveu0chvy.wl%tiwai@suse.de>
References: <20060326054542.GA11961@hermes.uziel.local>
	 <s5hveu0chvy.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 17:59:59 -0500
Message-Id: <1143500400.1792.314.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 12:16 +0200, Takashi Iwai wrote:
> > Any hints would be greatly appreciated! Thanks a bunch,
> 
> Try 2.6.16-git tree.  Some patches for this problem are there. 

If this does not fix the problem then alsa-devel (cc'ed) is the best
list to discuss the issue.

Lee

