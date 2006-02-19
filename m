Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWBSMwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWBSMwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 07:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBSMwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 07:52:00 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:56594 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932415AbWBSMv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 07:51:59 -0500
Date: Sun, 19 Feb 2006 13:52:24 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver 'w83627hf' needs updating - please use bus_type methods
Message-Id: <20060219135224.cf5ccce0.khali@linux-fr.org>
In-Reply-To: <0BF2E785-CC6D-4E4D-BDCF-AD21AEA10D36@bootc.net>
References: <0BF2E785-CC6D-4E4D-BDCF-AD21AEA10D36@bootc.net>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

> Just noticed the above message in my kernel log on my machine running  
> 2.6.16-rc2-ide2. I know there's a 2.6.16-rc4 now... I'm waiting to  
> upgrade until Alan comes up with new -ide patches or ATAPI over  
> libata/PATA starts working in -mm.
> 
> On another machine I also get:
> 
> Driver 'via686a' needs updating - please use bus_type methods

Already fixed in 2.6.16-rc4:
  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=41d9c98fe76298cebc5907bcebfb2db28017a277

Thanks for reporting though.

-- 
Jean Delvare
