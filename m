Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965366AbWAGAMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965366AbWAGAMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965367AbWAGAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:12:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61711 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965366AbWAGAMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:12:10 -0500
Date: Sat, 7 Jan 2006 01:12:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/reiser4/: misc cleanups
Message-ID: <20060107001209.GF3774@stusta.de>
References: <20060105223913.GK12313@stusta.de> <43BF0629.2030705@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BF0629.2030705@namesys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 04:07:05PM -0800, Hans Reiser wrote:
> Adrian Bunk wrote:
> 
> >This patch makes some needlessly global code static and #ifdef's some 
> >unused code away.
> >
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >  
> >
> Did we lose this patch from our patch process, or is this more cleanups
> from you?
>...

These are more cleanups.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

