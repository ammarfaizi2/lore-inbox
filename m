Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVB0PvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVB0PvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVB0PvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:51:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29713 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261407AbVB0Pu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:50:59 -0500
Date: Sun, 27 Feb 2005 16:50:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: remove include/sound/yss225.h
Message-ID: <20050227155057.GB6148@stusta.de>
References: <20050227125654.GA15206@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227125654.GA15206@apps.cwi.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 01:56:56PM +0100, Andries Brouwer wrote:
> The file include/sound/yss225.h is unused.
> 
> It is more or less identical to sound/oss/yss225.h,
> used by sound/oss/wavfront.c.
> 
> # rm include/sound/yss225.h

This is already in the ALSA tree (and therefore in 2.6.11-rc4-mm1).

> Andries
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

