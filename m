Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVBIBmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVBIBmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVBIBmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:42:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17924 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261735AbVBIBmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:42:38 -0500
Date: Wed, 9 Feb 2005 02:42:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Armin Schindler <armin@melware.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       developers@melware.de
Subject: Re: [2.6 patch] drivers/isdn/hardware/eicon/: misc possible cleanups
Message-ID: <20050209014235.GA2978@stusta.de>
References: <20050206003556.GK3129@stusta.de> <Pine.LNX.4.61.0502061110120.1053@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502061110120.1053@phoenix.one.melware.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 11:18:18AM +0100, Armin Schindler wrote:

> Hi Adrian,

Hi Armin,

> thanks for the proposed patch.
> Making the functions static is a good idea, I will check and test this.
> Removing some functions, especially from io.* and di.* is not good. These 
> functions are mainly used with other sub-drivers which are not part of the
> kernel. I will check if they are some really outdated and the removals in 
> message.c.

silly question:
Why are these sub-drivers not included in the kernel?

> Armin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

