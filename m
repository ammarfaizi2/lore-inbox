Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271186AbRHONut>; Wed, 15 Aug 2001 09:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271187AbRHONu3>; Wed, 15 Aug 2001 09:50:29 -0400
Received: from rasta.silver.com.ua ([193.41.160.2]:45580 "EHLO
	mail.silver.com.ua") by vger.kernel.org with ESMTP
	id <S271186AbRHONuX>; Wed, 15 Aug 2001 09:50:23 -0400
Date: Wed, 15 Aug 2001 16:50:25 +0300 (EEST)
From: Zakhar Kirpichenko <zakhar@silver.com.ua>
To: linux-kernel@vger.kernel.org
Subject: disk quota + 2.4.3 and higher -- OOPS
Message-ID: <Pine.LNX.4.10.10108151641270.10516-100000@rasta.silver.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	Hello over there.

	Sorry for offtopic (may be), but disk quotas don't work on Red Hat
Linux 7.1 and kernels 2.2.x and 2.4.x. Quota tools installed from RPM
package provided in standard RH distribution: quota-3.00-4, 2.4.2-2 kernel
sources taken from the dist too. Other kernel versions support quota
partially: repquota gives some quota statistics, but the kernel doesn't
update quota data until 'quotacheck' is run manually. Disk quotas don't
work too - even when repquota shows some limits, 'quota' doesn't and any
user can write to the fs inspite of the disk limits.

	Please, help if you have any ideas.

