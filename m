Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUCYTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbUCYTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:55:59 -0500
Received: from [199.243.65.9] ([199.243.65.9]:58402 "EHLO
	STHA37000.ca.ecamericas") by vger.kernel.org with ESMTP
	id S263593AbUCYTz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:55:56 -0500
Subject: linux-2.6.4 drivers/s390/net/qeth.c:7538: structure has no member named `dev_id'
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF2F3E046F.667A25FD-ON85256E62.006CF192@ca.ecamericas>
From: Jean-Francois.Martel@belairdirect.com
Date: Thu, 25 Mar 2004 14:55:18 -0500
X-MIMETrack: Serialize by Router on INGCSTHEXT01/SRV/ING-CANADA-Connect(Release 5.0.12
  |February 13, 2003) at 25/03/2004 02:50:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.6.4 kernel.org

drivers/s390/net/qeth.c: In function `qeth_ipv6_generate_eui64':
drivers/s390/net/qeth.c:7538: structure has no member named `dev_id'
drivers/s390/net/qeth.c:7539: structure has no member named `dev_id'
drivers/s390/net/qeth.c: In function `qeth_ipv6_init_card':
drivers/s390/net/qeth.c:7557: structure has no member named `dev_id'
drivers/s390/net/qeth.c:7559: structure has no member named
`generate_eui64'
make[2]: *** [drivers/s390/net/qeth.o] Error 1
make[1]: *** [drivers/s390/net] Error 2
make: *** [drivers/s390] Error 2



Linux 2.4.21-107-default #1 SMP Thu Mar 11 17:20:12 UTC 2004 s390 unknown

Gnu C                  3.2.2
Gnu make               3.79.1
mount                  2.11u
module-init-tools      writing
e2fsprogs              1.28
jfsutils               1.0.24
nfs-utils              1.0.1
Linux C Library        26 11:37 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.2
Procps                 3.1.11
Net-tools              1.60
Kbd                    76:
Sh-utils               2.0
Modules Loaded         qeth ipv6 key qdio reiserfs dm-mod dasd_eckd_mod
dasd_mod ext3 jbd


