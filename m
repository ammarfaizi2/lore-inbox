Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVHTAUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVHTAUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbVHTAUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:20:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28947 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932349AbVHTAU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:20:29 -0400
Date: Sat, 20 Aug 2005 02:20:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: 2.6.13-rc6-mm1: why is PHYLIB a user-visible option?
Message-ID: <20050820002027.GJ3615@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason why PHYLIB is a user-visible option?

As far as I understand it, PHYLIB and the MII PHY device drivers are an 
internal library drivers should start to use roughly similar to MII.

But in this case, the options shouldn't be user-visible.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

