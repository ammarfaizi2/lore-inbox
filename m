Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVAXR5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVAXR5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVAXRz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:55:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41479 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261550AbVAXRyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:54:53 -0500
Date: Mon, 24 Jan 2005 18:54:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124175449.GK3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems noone who reviewed the SuperIO patches noticed that there are 
now two modules "scx200" in the kernel...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

