Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289573AbSAOO0m>; Tue, 15 Jan 2002 09:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289642AbSAOO0X>; Tue, 15 Jan 2002 09:26:23 -0500
Received: from delrom.ro ([193.231.234.28]:56214 "EHLO delrom.ro")
	by vger.kernel.org with ESMTP id <S289573AbSAOO0N>;
	Tue, 15 Jan 2002 09:26:13 -0500
Date: Tue, 15 Jan 2002 16:26:47 +0200
From: Silviu Marin-Caea <silviu@delrom.ro>
To: linux-kernel@vger.kernel.org
Subject: Ramdisk doesn't work well in 2.4.17
Message-Id: <20020115162647.35f57d4f.silviu@delrom.ro>
Organization: Delta Romania
X-Mailer: Sylpheed version 0.7.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to make a pair of custom boot/root diskettes (for partimage).

The kernel I have compiled the kernel for bootdisk loads fine, reads the
rootdisk (gzipped image) to the end, and then, it says:


Kernel panic: no init found.  Try passing init= option to kernel.



The root disk is good, because I have built a 2.4.9 in a similar
fashion, and it works with it.  The problem is I need NTFS support, and
that doesn't compile in 2.4.9.



-- 
Silviu Marin-Caea - Network & Systems Administrator - Delta Romania
Phone +4093-267961

