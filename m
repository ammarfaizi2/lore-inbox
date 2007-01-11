Return-Path: <linux-kernel-owner+w=401wt.eu-S965309AbXAKHBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbXAKHBe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbXAKHBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:01:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3623 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965309AbXAKHBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:01:33 -0500
Date: Thu, 11 Jan 2007 08:01:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: x86_64: up to 255 or 256 CPUs?
Message-ID: <20070111070138.GD21724@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting arch/x86_64/Kconfig:

<--  snip  -->

...
config NR_CPUS
        int "Maximum number of CPUs (2-256)"
        range 2 255
...


<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

