Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVHJTH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVHJTH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVHJTH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:07:57 -0400
Received: from mail.possibilityforge.com ([209.33.206.30]:44294 "EHLO
	possibilityforge.com") by vger.kernel.org with ESMTP
	id S1030207AbVHJTH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:07:56 -0400
Message-ID: <42FA5082.8080907@possibilityforge.com>
Date: Wed, 10 Aug 2005 13:07:46 -0600
From: Jon Scottorn <jscottorn@possibilityforge.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel panic 2.6.12.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102.6
X-Spam-Report: Spam detection software, running on the system "mail.possibilityforge.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, I am in need of some help! I have installed Debian
	which has 2.6.8-2 kernel on it. After a fresh install I downloaded the
	2.6.12.4 kernel and went to upgrade. After making the necessary changes
	in menuconfig I rebuilt the kernel and install it. It boots up until I
	get: Modules linked in: CPU: 0 EIP: 0060:[c026d55d] Not tainted VLI
	EFLAGS: 00010006 (2.6.12.4) EIP is at adpt_isr+0x178/0x1f5 ....... Cut
	out for space and time as I am typeing it all in. ........ <0>Kernel
	panic - not syncing: Fatal exception in interrupt [...] 
	Content analysis details:   (-102.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-100 USER_IN_WHITELIST      From: address is in the user's white-list
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   I am in need of some help!
I have installed Debian which has 2.6.8-2 kernel on it.  After a fresh
install I downloaded the 2.6.12.4 kernel and went to upgrade.  After
making the necessary changes in menuconfig I rebuilt the kernel and
install it.  It boots up until I get:
Modules linked in:
CPU:       0
EIP:         0060:[c026d55d]   Not tainted VLI
EFLAGS: 00010006    (2.6.12.4)
EIP is at adpt_isr+0x178/0x1f5
.......
Cut out for space and time as I am typeing it all in. 
........
<0>Kernel panic - not syncing: Fatal exception in interrupt

Any help would be greatly appreciated.
I have been messing with this issue for the past 3 days now.  I have
tried 2.6.11, 2.6.11.11, 2.6.12, 2.6.12.3, 2.6.12.4 and all of those
kernels end up with the same problem.

Thanks in advance.

Jon
