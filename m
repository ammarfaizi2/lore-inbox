Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbTCRSSq>; Tue, 18 Mar 2003 13:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262527AbTCRSSq>; Tue, 18 Mar 2003 13:18:46 -0500
Received: from imspcml003.netvigator.com ([218.102.32.60]:20522 "EHLO
	imspcml003.netvigator.com") by vger.kernel.org with ESMTP
	id <S262526AbTCRSSp>; Tue, 18 Mar 2003 13:18:45 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 - 2.4.21-pre5 TM5600 /dev/cpu/0/cpuid incompatible with longrun
Date: Wed, 19 Mar 2003 02:28:45 +0800
User-Agent: KMail/1.5
Cc: mflt1@micrologica.com.hk
x-os: GNU/Linux 2.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303190228.45889.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.4.19 longrun 0.9 (2001-02-14) does no longer work.

# longrun -p
longrun: error reading /dev/cpu/0/cpuid: Invalid argument


# cat /dev/cpu/0/cpuid
GenuMx86ineTC?

	Michael

plase cc to me.




