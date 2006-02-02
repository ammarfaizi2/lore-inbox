Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422979AbWBBBcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422979AbWBBBcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423043AbWBBBcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:32:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56335 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422979AbWBBBcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:32:23 -0500
Date: Thu, 2 Feb 2006 02:32:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       rpurdie@rpsys.net
Subject: Re: LED: Add IDE disk activity LED trigger
Message-ID: <20060202013218.GU3986@stusta.de>
References: <20060131203552.GG4215@suse.de> <20060131212249.GR31163@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131212249.GR31163@cosmic.amd.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 02:22:49PM -0700, Jordan Crouse wrote:
>...
> Perhaps it can be hidden behind a CONFIG_EMBEDDED or something so that
> the desktop platforms aren't bothered by it, but speaking for the two 
> embedded platforms I'm attached to, my vote for this LED class is a "yes".

CONFIG_EMBEDDED does _not_ mean "this is an embedded device" (opposed 
to desktop/server/...).

It means "show me some 'use this only if you know what you are doing' 
options for additional space savings".

> Jordan Crouse

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

