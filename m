Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVB1WsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVB1WsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVB1WsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:48:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261799AbVB1WsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:48:15 -0500
Date: Mon, 28 Feb 2005 23:48:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mmcclell@bigfoot.com
Cc: linux-usb-devel@lists.sourceforge.ne, linux-kernel@vger.kernel.org
Subject: status of the USB ov511.c driver in kernel 2.6?
Message-ID: <20050228224813.GT4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the following regarding the drivers/usb/media/ov511.c driver:
- it's not updated compared to upstream:
  - version 1.64 is neither version 2 nor the latest 1.x version 1.65
- there's no *_decomp.c module in the kernel sources

Are there any reasons why the upstream driver can't be resynced with the 
kernel?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

