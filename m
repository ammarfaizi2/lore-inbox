Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVG1NtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVG1NtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVG1NpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:45:25 -0400
Received: from gate.perex.cz ([82.113.61.162]:56495 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261437AbVG1Nnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:43:51 -0400
Date: Thu, 28 Jul 2005 15:43:49 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Adrian Bunk <bunk@stusta.de>, Lee Revell <rlrevell@joe-job.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, Takashi Iwai <tiwai@suse.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <1122559208.32126.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0507281542420.8458@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>  <1122393073.18884.29.camel@mindpipe>
 <42E65D50.3040808@pobox.com>  <20050727182427.GH3160@stusta.de>
 <20050727203150.GF22686@tuxdriver.com>  <42E7F1F9.2050105@pobox.com>
 <1122559208.32126.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Alan Cox wrote:

> On Mer, 2005-07-27 at 16:43 -0400, Jeff Garzik wrote:
> > ISTR Alan saying there was some ALi hardware that either wasn't in ALSA, 
> > or most likely didn't work in ALSA.  If Alan says I'm smoking crack, 
> > then you all can ignore me :)
> 
> The only big thing I know that still needed OSS (and may still do so) is
> the support for AC97 wired touchscreens and the like. Has that been
> ported to ALSA ?

We're working on this issue right now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
