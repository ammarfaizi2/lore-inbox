Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283166AbRLDOoh>; Tue, 4 Dec 2001 09:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283713AbRLDOo3>; Tue, 4 Dec 2001 09:44:29 -0500
Received: from cm61-15-169-117.hkcable.com.hk ([61.15.169.117]:2432 "EHLO
	cm61-15-169-117.hkcable.com.hk") by vger.kernel.org with ESMTP
	id <S283697AbRLDOnZ>; Tue, 4 Dec 2001 09:43:25 -0500
Subject: Unresolved symbols of loop device
From: David Chow <davidchow@rcn.com.hk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 22:38:41 +0800
Message-Id: <1007476721.1790.0.camel@cm61-15-169-117.hkcable.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Since 2.4.1x, I found I always got the following error? Why? I am using
Redhat 7.2 stock standard. Why is that? I guess you people must have
been using loop device correctly... Thanks.


root]# modprobe loop
/lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol
deactivate_page
/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod
/lib/modules/2.4.14/kernel/drivers/block/loop.o failed
/lib/modules/2.4.14/kernel/drivers/block/loop.o: insmod loop failed


