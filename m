Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVAGSZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVAGSZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVAGSXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:23:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:12419 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261526AbVAGSOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:14:44 -0500
Message-ID: <41DEC82C.4040502@osdl.org>
Date: Fri, 07 Jan 2005 09:34:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.x features log
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think that people really like the Dave Jones
2.5/2.6 halloween information/update.  It contained a lot
of useful info in one place, with pointers to more details.

What I'm seeing (and getting a little concerned about,
although I dislike PR with a passion) is that the 2.6.x
continuous development cycle will cause us (the Linux
community) to miss logging some of these important new
features (outside of bk).  Has anyone kept a track of new
features that are being added in 2.6?

I'll keep a list (or someone else can -- DaveJ ?) if anyone
is interested in feeding items into it.  Or do distros
already keep such a running list of new features?

For example (and some of these might not be needed here):

- NUMA support and API, including some CPU affinity updates
- hotplug and udev
- security fixes
- better ACPI support, better interrupt routing, MSI support
- faster pipes


Thoughts?

Thanks,
-- 
~Randy
