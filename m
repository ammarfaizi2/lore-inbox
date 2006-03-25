Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWCYTBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWCYTBH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCYTBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:01:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12816 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932247AbWCYTBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:01:05 -0500
Date: Sat, 25 Mar 2006 20:01:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Fix compilation for sound/oss/vwsnd.c
Message-ID: <20060325190103.GO4053@stusta.de>
References: <1143151469.13816.1.camel@alice> <1143151741.14516.1.camel@alice> <Pine.LNX.4.61.0603251936080.29793@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603251936080.29793@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 07:36:31PM +0100, Jan Engelhardt wrote:
> >sorry,
> >
> >fixed patch below between all the switching i forgot to remove
> >the declaration in li_create()
> >
> 
> It would have been a lot simpler to add a (proper) prototype.

Eric's patch looks fine.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

