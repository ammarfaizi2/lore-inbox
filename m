Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbSLEBhi>; Wed, 4 Dec 2002 20:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbSLEBhi>; Wed, 4 Dec 2002 20:37:38 -0500
Received: from f121.law15.hotmail.com ([64.4.23.121]:4624 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267175AbSLEBhh>;
	Wed, 4 Dec 2002 20:37:37 -0500
X-Originating-IP: [61.129.109.226]
From: "Yiyan Yang" <edwardyang6@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: new kernel can't boot
Date: Thu, 05 Dec 2002 09:45:05 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F121O3YnDKvLVFDWTYT00001ed0@hotmail.com>
X-OriginalArrivalTime: 05 Dec 2002 01:45:05.0727 (UTC) FILETIME=[EF8594F0:01C29BFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

im using RHAS 2.1 kernel 2.4.9-e.3, to install oracle RAC on the server, we
have to change some parameter(character device - watch dog) and rebuild 
kernel.

I build the kernel according to the customization manual but the kernel 
fails
to boot, the error is:

  Kernel Panic: VFS: Unable to mount root fs on 01:00

My root is on ext3 FS and I did the mkinitrm RAM Disk.
Cause im not in the email-list, please directly reply to me.

Thanks very much.



_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

