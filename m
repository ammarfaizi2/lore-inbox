Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSFXUA2>; Mon, 24 Jun 2002 16:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSFXUA1>; Mon, 24 Jun 2002 16:00:27 -0400
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:55051 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S315210AbSFXUA1>; Mon, 24 Jun 2002 16:00:27 -0400
Subject: 2.4.19-rc1 error in depmod with mtd
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Jun 2002 12:54:03 -0700
Message-Id: <1024948445.2225.127.camel@shire.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to make modules_install,

depmod: *** Unresolved symbols in
/lib/modules/2.4.19-rc1/kernel/drivers/mtd/maps/sc520cdp.o
depmod: 	mtd_concat_create_R606fc87b
depmod: 	mtd_concat_destroy_R9c645004
make: *** [_modinst_post] Error 1

- - -
Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com

