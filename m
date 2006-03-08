Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWCHWHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWCHWHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWCHWHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:07:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44045 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030225AbWCHWHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:07:12 -0500
Date: Wed, 8 Mar 2006 23:07:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Miguel Blanco <mblancom@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: problem mounting a jffs2 filesystem
Message-ID: <20060308220710.GQ4006@stusta.de>
References: <8766c4ce0603050504h24b445c5t@mail.gmail.com> <1141652131.4110.47.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141652131.4110.47.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 01:35:31PM +0000, David Woodhouse wrote:
> On Sun, 2006-03-05 at 14:04 +0100, Miguel Blanco wrote:
> >  divide error: 0000 [#1]
> >  EIP is at jffs2_scan_medium+0xdf/0x55e [jffs2]
> 
> Can you try it with the attached patch? Or turn off
> CONFIG_JFFS2_FS_WRITEBUFFER

This patch seems to be 2.61.6 stuff?

> dwmw2
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

