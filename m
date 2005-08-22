Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVHVWXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVHVWXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVHVWWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:22:35 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:44424 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751379AbVHVWWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:32 -0400
Date: Mon, 22 Aug 2005 11:53:47 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6: halt instead of reboot
In-Reply-To: <m14q9iva4q.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
 <m14q9iva4q.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does reboot=hard (on the kernel command line) change the behaviour?

Will try in the evening.

> Does magic sysrq work after the system hangs?

It does not hang, it just powers off like on halt.

> Can you narrow it down to a -git snapshot where reboot breaks for
> you?

Quite hard - it's a production multiuser machine and gateway. Will see 
what I can find.

-- 
Meelis Roos (mroos@linux.ee)
