Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUE3NdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUE3NdS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUE3NdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:33:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30146 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263736AbUE3NdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:33:17 -0400
Date: Sun, 30 May 2004 15:33:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Gigabit Kconfig problems with yesterday's update
Message-ID: <20040530133300.GD13111@fs.tum.de>
References: <40B8A37D.1090802@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B8A37D.1090802@myrealbox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 07:51:41AM -0700, walt wrote:
> I have one machine with a gigabit NIC which I updated today from Linus'
> bk tree.
> 
> The problem is that I was not asked if I wanted the 'new' gigabit
> support and therefore the tg3 support was dropped from my new .config.
> 
> I edited .config by hand and deleted any mention of ethernet support --
> and only then did 'make oldconfig' ask me the right questions.
>...

Please send your old .config .

> Thanks!

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

