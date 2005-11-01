Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVKAOzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVKAOzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKAOzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:55:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7955 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750828AbVKAOzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:55:42 -0500
Date: Tue, 1 Nov 2005 15:55:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Kyle McMartin <kyle@parisc-linux.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20051101145538.GS8009@stusta.de>
References: <20051030105118.GW4180@stusta.de> <20051030142752.GE6475@tachyon.int.mcmartin.ca> <20051030151256.GZ4180@stusta.de> <1130777453.32101.46.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130777453.32101.46.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:50:52AM -0500, Lee Revell wrote:
> On Sun, 2005-10-30 at 16:12 +0100, Adrian Bunk wrote:
> > 
> > ALSA bugs [1] #1301 and #1302 are still open.
> 
> I think these bug reports can be disregarded.  The submitter never
> responded to requests to retest with the latest ALSA version.  #1302 is
> almost certainly a bug in kphone anyway.

If these bugs will be marked as resolved/closed when I'll send the next 
batch of OSS driver removals a few months from now, SOUND_AD1816 will be 
part of this batch.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

