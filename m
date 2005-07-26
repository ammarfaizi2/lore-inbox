Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVGZGgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVGZGgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVGZGbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:31:51 -0400
Received: from gate.perex.cz ([82.113.61.162]:29080 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S261776AbVGZG3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:29:50 -0400
Date: Tue, 26 Jul 2005 08:29:49 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103-a.perex-int.cz
To: Andrew Haninger <ahaning@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
In-Reply-To: <105c793f05072507315cfd1878@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507260828030.8190@tm8103-a.perex-int.cz>
References: <105c793f05072507315cfd1878@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005, Andrew Haninger wrote:

> Hello.
> 
> I have a 5 year old Gateway Solo 2500 that is currently running Linux
> 2.6.12.2. If I install ALSA and try to have alsaconf bruteforce-detect
> the OPL3SA2 sound card, it will say that it has detected it, but
> loading the modules will fail. If I install Linux 2.4 and
> recompile/rerun alsaconf, the detection works fine and the card works.
> Copying the configuration detected under 2.4 into a modprobe.conf on
> 2.6 allows me to use the card in 2.6 with occasional crashes (which
> might be due to suspend2).

Please, report this problem to our bug-tracking-system:

https://bugtrack.alsa-project.org/alsa-bug

We have already two similar reports #440 and #879. Please, provide us
all info (working manual conf etc.)..

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
