Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVD3MqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVD3MqI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 08:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVD3MqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 08:46:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33034 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261211AbVD3MqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 08:46:04 -0400
Date: Sat, 30 Apr 2005 14:46:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc3-mm1 doesn't boot
Message-ID: <20050430124603.GA3528@stusta.de>
References: <20050429231653.32d2f091.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.12-rc3-mm1 doesn't boot on my computer.

Comparing the point where booting stops with a boot from a working 
kernel, the first line that isn't displayed is the line where init says 
it's starting.

Ctrl-Alt-Del at this point reboots my computer.

Both 2.6.12-rc3 and 2.6.12-rc2-mm3 do boot.

My computer is a cheap desktop computer with one 1,8 GHz Athlon CPU.

I know what a binary search is, but since I currently need my computer 
and I can't do 10 compile and reboot cycles today any hints which 
patches are suspect of being guilty is appreciated.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

