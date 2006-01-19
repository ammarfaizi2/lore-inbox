Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWASS3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWASS3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWASS3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:29:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41220 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030301AbWASS3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:29:01 -0500
Date: Thu, 19 Jan 2006 19:28:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060119182859.GW19398@stusta.de>
References: <20060119174600.GT19398@stusta.de> <1137694944.32195.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137694944.32195.1.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 01:22:23PM -0500, Lee Revell wrote:
> On Thu, 2006-01-19 at 18:46 +0100, Adrian Bunk wrote:
> > 3. no ALSA drivers for the same hardware
> > 
> > SOUND_SB 
> 
> ALSA certainly does support "100% Sound Blaster compatibles (SB16/32/64,
> ESS, Jazz16)", it would be a joke if it didn't...

That's not the problem, I should have added an explanation:

SOUND_SB (due to SOUND_KAHLUA and SOUND_PAS)

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

