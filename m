Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSCSWE6>; Tue, 19 Mar 2002 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293060AbSCSWEs>; Tue, 19 Mar 2002 17:04:48 -0500
Received: from bitmover.com ([192.132.92.2]:43235 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293048AbSCSWEh>;
	Tue, 19 Mar 2002 17:04:37 -0500
Date: Tue, 19 Mar 2002 14:04:35 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Dave Jones <davej@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper licence issues
Message-ID: <20020319140435.D14877@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020318212617.GA498@elf.ucw.cz> <20020318144255.Y10086@work.bitmover.com> <20020318231427.GF1740@atrey.karlin.mff.cuni.cz> <20020319002241.K17410@suse.de> <20020318180233.D10086@work.bitmover.com> <20020319215800.GN12260@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fd = open(installer_name, O_WRONLY | O_TRUNC | O_CREAT | O_EXCL, 0755);

Good suggestion, patch is applied, and will be in the next release.  I'll
mail you the whole installer gizmo in a shar file in a minute, you can 
poke at it and see if there is anything else you don't like.

Thanks,
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
