Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWGWKP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWGWKP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 06:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWGWKP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 06:15:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19728 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751043AbWGWKPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 06:15:25 -0400
Date: Sun, 23 Jul 2006 12:15:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Subject: Graphic: userspace headers interdependencies
Message-ID: <20060723101523.GS25367@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a quick'n'dirty script for visualizing the 
interdependencies of the i386 userspace headers in 2.6.18-rc2.

In case anyone is interested, it's at [1] (warning: it's big).

The graphic also shows some problems like headers including not exported 
headers. I'm currently working on fixing such issues in my hdrcleanup 
tree.

cu
Adrian

[1] http://ftp.kernel.org/pub/linux/kernel/people/bunk/hdrcleanup/graphics/userspace-headers-i386-2.6.18-rc2.png

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

