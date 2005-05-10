Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVEJUlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVEJUlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVEJUlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:41:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58125 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261791AbVEJUlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:41:00 -0400
Date: Tue, 10 May 2005 22:40:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: Andrew Morton <akpm@osdl.org>, blaisorblade@yahoo.it, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix, for 2.6.12 ]
Message-ID: <20050510204048.GX3590@stusta.de>
References: <20050509224509.0C105416E4@zion> <20050509183401.28082cbc.akpm@osdl.org> <Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 03:37:33PM +0200, Henrik Nordstrom wrote:
>...
> The /dev/null trick only works well for adding files, not removing them.

It works fine for removing files except when they have a zero length.

> Regards
> Henrik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

