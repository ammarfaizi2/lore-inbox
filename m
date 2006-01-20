Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWATTER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWATTER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWATTER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:04:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750803AbWATTEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:04:15 -0500
Date: Fri, 20 Jan 2006 20:04:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different approach
Message-ID: <20060120190415.GM19398@stusta.de>
References: <20060119174600.GT19398@stusta.de> <20060120115443.GA16582@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120115443.GA16582@palantir8>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 11:54:43AM +0000, Martin Habets wrote:

> It seems to me we can already get rid of sound/oss/dmasound now.
> I cannot find anything refering to it anymore, and the ALSA powermac
> driver is being maintained.

You are correct that I forgot to add the dmasound drivers to my list, 
but I don't think we can get rid of all of them since I doubt the ALSA 
powermac driver was able to drive m68k hardware.

Can someone from the ppc developers drop me a small note whether 
SND_POWERMAC completely replaces DMASOUND_PMAC?

> Martin

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

