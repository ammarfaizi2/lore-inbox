Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVAPSyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVAPSyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVAPSyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:54:46 -0500
Received: from gprs214-69.eurotel.cz ([160.218.214.69]:43245 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262567AbVAPSym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:54:42 -0500
Date: Sun, 16 Jan 2005 19:53:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
Subject: Re: [2.6 patch] i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk
Message-ID: <20050116185351.GA2757@elf.ucw.cz>
References: <20050116073927.GU4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116073927.GU4274@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> acpi_save_state_disk does nothing and is completely unused.
> 
> Unless some usage is planned in the near future, I'm therefore proposing 
> the patch below to kill it.

Good idea.
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
