Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265695AbUGDOTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUGDOTM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 10:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbUGDOTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 10:19:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12181 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265695AbUGDOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 10:19:10 -0400
Date: Sun, 4 Jul 2004 08:33:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040704063321.GB5054@openzaurus.ucw.cz>
References: <40E76CC5.6020903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E76CC5.6020903@pobox.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This appeared in -bk-latest in the past day or two.
> 
> BK-current on x86-64 (config/dmesg/lspci attached) will pause for 30 
> wall-clock seconds immediately after being loaded by the bootloader, 
> then will proceed to boot successfully and function correctly.  This 
> is reproducible on every boot.
> 
> So, 30 seconds with no printk output, then boots normally.
> 

Search archives, there was something similar seen before.
It was related to EDD, or some similar BIOS feature, IIRC.




-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

