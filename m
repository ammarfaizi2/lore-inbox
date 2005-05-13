Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVEMOj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVEMOj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVEMOjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:39:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3334 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262393AbVEMOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:37:22 -0400
Date: Fri, 13 May 2005 16:37:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] [2.6 patch] sound/isa/: possible cleanups
Message-ID: <20050513143720.GH16549@stusta.de>
References: <20050513140053.GF16549@stusta.de> <s5hd5rvryaw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd5rvryaw.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 04:32:55PM +0200, Takashi Iwai wrote:
>...
> The unused stuff in sound/isa/gus/* are for (everlasting :) future
> development, e.g. WaveTable synth support.  So I don't think it's a
> good idea to remove completely them.
>...

Would a patch to #if 0 them away be OK?

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

