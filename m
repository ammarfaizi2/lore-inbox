Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751884AbWAOJzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWAOJzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 04:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWAOJzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 04:55:33 -0500
Received: from outmx020.isp.belgacom.be ([195.238.4.201]:28110 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751884AbWAOJzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 04:55:32 -0500
Date: Sun, 15 Jan 2006 10:55:05 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       David Woodhouse <dwmw2@infradead.org>, Jens Axboe <axboe@suse.de>,
       Steven French <sfrench@us.ibm.com>, Roland Dreier <rolandd@cisco.com>,
       Anton Altaparmakov <aia21@cantab.net>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: git status (was: drm tree for 2.6.16-rc1)
Message-ID: <20060115095504.GA4219@infomag.infomag.iguana.be>
References: <Pine.LNX.4.58.0601120948270.1552@skynet> <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org> <20060112134255.29074831.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112134255.29074831.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> watchdog: Wim has been very quiet in recent months.  No problems
>           of which I'm aware.

No problems at this moment, except that the i8xx_tco driver doesn't 
seem to work on ICH6. Apparently Intel changed something after the 
ICH5 chipsets... Still need to look at that...
There is also a SuperMicro update that needs to go in for the 
i8xx_tco driver.
For the rest I have been working on the Berkshire PC-Watchdog ISA card.

Greetings,
Wim.

