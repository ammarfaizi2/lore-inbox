Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280968AbRKOSEI>; Thu, 15 Nov 2001 13:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280969AbRKOSD5>; Thu, 15 Nov 2001 13:03:57 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:58078 "EHLO
	c0mailgw13.prontomail.com") by vger.kernel.org with ESMTP
	id <S280968AbRKOSDs>; Thu, 15 Nov 2001 13:03:48 -0500
Message-ID: <3BF4035F.E617D8E5@starband.net>
Date: Thu, 15 Nov 2001 13:03:12 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Documentation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any relatively new documents on how to optimize /proc system
variables?
Securing and Optimizing RedHat Linux had a few,
/usr/src/linux/Documentation has a few.
Are there any current papers/documents that encompass all of the
settings and options that you can set?

ie: for 1 GB of ram
echo "100 1200 128 512 15 5000 500 1884 2" > /proc/sys/vm/bdflush
Would be used.

However, this was taken from either a 2.2.x kernel or early 2.4.

Anyone know if any docs currently exist which explain how to tweak each
setting and what each setting means?



