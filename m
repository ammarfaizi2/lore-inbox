Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVAaTOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVAaTOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVAaTOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:14:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29715 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261320AbVAaTOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:14:14 -0500
Date: Mon, 31 Jan 2005 20:14:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/tty_io.c: remove console_use_vt
Message-ID: <20050131191410.GC18316@stusta.de>
References: <20050131174105.GW18316@stusta.de> <20050131190522.GA17096@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131190522.GA17096@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 08:05:22PM +0100, Olaf Hering wrote:
>  On Mon, Jan 31, Adrian Bunk wrote:
> 
> > The global variable console_use_vt never changed its' value.
> 
> I think that comes from xen.

Ah thanks, I somehow missed that.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

