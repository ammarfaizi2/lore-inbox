Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268660AbRHFO0m>; Mon, 6 Aug 2001 10:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268674AbRHFO0c>; Mon, 6 Aug 2001 10:26:32 -0400
Received: from mercury.eng.emc.com ([168.159.40.77]:57871 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S268660AbRHFO0X>; Mon, 6 Aug 2001 10:26:23 -0400
Message-ID: <276737EB1EC5D311AB950090273BEFDD043BC549@elway.lss.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'lermen@fgan.de'" <lermen@fgan.de>
Cc: linux-kernel@vger.kernel.org
Subject: Problems in using loadLin
Date: Mon, 6 Aug 2001 10:20:46 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to use loadlin to boot up a machine. But after I 
replaced the bzImage, the kernel fails to boot up. It prints 
out error messages like:
	...
	VFS: Mounted root (ext2 filesystem) readonly
	Freeing unused kernel memory : 96K freed
	Warning: unable to open an initial console
	Kernel panic: No init found. Try passing init= option to kernel.

The boot.bat file is:
	loadlin.exe bzImage ro root=0x0821

Thanks,

Xiangping
