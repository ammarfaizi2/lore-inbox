Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVERKbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVERKbi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVERKbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:31:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3856 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262155AbVERKbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:31:33 -0400
Date: Wed, 18 May 2005 12:31:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: hostap gone from 2.6.12-rc4-mm2?
Message-ID: <20050518103129.GU5112@stusta.de>
References: <20050518090255.GD28766@gamma.logic.tuwien.ac.at> <20050518021708.23e9ed51.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518021708.23e9ed51.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 02:17:08AM -0700, Andrew Morton wrote:
> Norbert Preining <preining@logic.at> wrote:
> >
> >  The hostap wireless driver is missing from 2.6.12-rc4-mm2. I miss it ;-)
> 
> oop, I accidentally commented out the relevant tree.   With luck you can add
> http://www.zip.com.au/~akpm/linux/patches/stuff/git-netdev-wifi.patch

According to your 2.6.12-rc4-mm2 announcement, this was intentionally:

<--  snip  -->

+#git-netdev-wifi.patch

 This isn't included because it's busted.

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

