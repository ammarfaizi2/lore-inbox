Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVCGM1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVCGM1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 07:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVCGM1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 07:27:22 -0500
Received: from gate.perex.cz ([82.113.61.162]:40900 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S261479AbVCGM1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 07:27:10 -0500
Date: Mon, 7 Mar 2005 13:15:59 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6: sound/isa/gus/gus_lfo.c is unused (fwd)
In-Reply-To: <20050306224159.GQ5070@stusta.de>
Message-ID: <Pine.LNX.4.58.0503071310140.1751@pnote.perex-int.cz>
References: <20050306224159.GQ5070@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005, Adrian Bunk wrote:

> Hi Jaroslav,
> 
> I didn't receive any answer regarding this question.
> 
> Any comments or shall I send a patch to remove this file?

Yes, the file is unused, but it's a library for wavetable stuff which has 
not been ported from my linux ultra sound project yet.

I removed this file in our CVS tree, so it will be removed also in ALSA BK 
tree in next merge.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
