Return-Path: <linux-kernel-owner+w=401wt.eu-S1751011AbWLOIo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWLOIo7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWLOIo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:44:59 -0500
Received: from gate.perex.cz ([212.20.107.50]:59257 "EHLO gate.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbWLOIo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:44:58 -0500
Date: Fri, 15 Dec 2006 09:44:56 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [ALSA PATCH] alsa-git merge request
In-Reply-To: <20061215001722.616ea1a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0612150943590.13335@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0612150849410.13335@tm8103.perex-int.cz>
 <20061215001319.b6dd7198.akpm@osdl.org> <20061215001722.616ea1a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006, Andrew Morton wrote:

> On Fri, 15 Dec 2006 00:13:19 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > It's going to need this fix
> 
> And this one, which was sent and ignored a week ago.
> 
> Consideration of the below review comments would be useful, too.
> 
> 
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Fix the soc code after dhowells workqueue changes.

I applied this patch to alsa-git tree.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
