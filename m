Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVACXLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVACXLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVACXLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:11:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2820 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261922AbVACXKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:10:30 -0500
Date: Tue, 4 Jan 2005 00:10:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <roland@topspin.com>
Cc: mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] infiniband: possible cleanups
Message-ID: <20050103231024.GP2980@stusta.de>
References: <20050103171937.GG2980@stusta.de> <52sm5i70um.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52sm5i70um.fsf@topspin.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 11:45:53AM -0800, Roland Dreier wrote:
> Thanks, I've applied the changes adding "static" to our tree.  I'm
> holding off on the "#if 0" changes since some is code useful for
> debugging modules and other code is used by modules in development.

Is there an ETA when the debugging modules and the modules in 
development will be merged into the kernel?

> Thanks,
>   Roland

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

