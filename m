Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUKIUbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUKIUbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUKIUbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:31:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261683AbUKIUa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:30:57 -0500
Date: Tue, 9 Nov 2004 21:30:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, tulip-users@lists.sourceforge.net,
       linux-net@vger.kernel.org
Subject: 2.6.10-rc1-mm4: net/tulip/xircom_tulip_cb.c compile error
Message-ID: <20041109203024.GA5892@stusta.de>
References: <20041109074909.3f287966.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109074909.3f287966.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 07:49:09AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc1-mm3:
>...
>  bk-netdev.patch
>...

<--  snip  -->

...
  CC      drivers/net/tulip/xircom_tulip_cb.o
drivers/net/tulip/xircom_tulip_cb.c: In function `__check_debug':
drivers/net/tulip/xircom_tulip_cb.c:122: error: `debug' undeclared (first use in this function)
drivers/net/tulip/xircom_tulip_cb.c:122: error: (Each undeclared identifier is reported only once
drivers/net/tulip/xircom_tulip_cb.c:122: error: for each function it appears in.)
...
make[3]: *** [drivers/net/tulip/xircom_tulip_cb.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

