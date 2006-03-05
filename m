Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752148AbWCEHYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbWCEHYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbWCEHYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:24:49 -0500
Received: from mail.gmx.de ([213.165.64.20]:2218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752148AbWCEHYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:24:49 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.16-rc5-mm2
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Alessandro Zummo <a.zummo@towertech.it>
In-Reply-To: <20060304222657.0df4f7cc.akpm@osdl.org>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
	 <33rh02d65h18t6fo9j3reoaovd8kekjd88@4ax.com>
	 <20060304222657.0df4f7cc.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 05 Mar 2006 08:24:48 +0100
Message-Id: <1141543488.8964.42.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 22:26 -0800, Andrew Morton wrote:
> Grant Coady <gcoady@gmail.com> wrote:

> > Alsa:
> > Why do I want these by default?
> > OSS PCM (digital audio) API - Include plugin system (SND_PCM_OSS_PLUGINS) [Y/n/?] (NEW)
> > Verbose procfs contents (SND_VERBOSE_PROCFS) [Y/n/?] (NEW)
> 
> cc's added.

Those PCM bits are probably good to have on as default for a while.
Some of the audio toys that came with my pretty recent SuSE10
installation stopped working when I tried to be an alsa purist.

	-Mike

