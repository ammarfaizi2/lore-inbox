Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTH2NDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbTH2NDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:03:47 -0400
Received: from [62.12.131.37] ([62.12.131.37]:34525 "HELO debian")
	by vger.kernel.org with SMTP id S261196AbTH2NDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:03:43 -0400
User-Agent: Microsoft-Entourage/10.0.0.1309
Date: Fri, 29 Aug 2003 15:03:16 +0200
Subject: Installed benh 2.4.22-ben1, maschine hangs
From: Zeno Davatz <zdavatz@ywesee.com>
To: <linux-kernel@vger.kernel.org>
Message-ID: <BB751BB4.6D80%zdavatz@ywesee.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I installed the newest Kernel with rsync, done make menuconfig, make-kpkg
clean, make-kpkg kernel_image and dpkg --install kerne_image...

Now when I reboot I get:
Vector 700 at pc = 00000200, lr=c00ca708 msr =80000, sp = c0b13ea0
[c0b13df0] current = c0b12000, pid=1, comm = swapper

What can I do to get my maschine back up? It hangs after above message.

Ben says:
>Hrm... You would have been wise to keep the older kernel around...

>Yes, you can boot from the CD or the rescue floppy, you can actually
>load the CD's kernel from yaboot and have it root on your HD, I'd
>suggest you ask on the mailing lists for more details

Thanks for your help.

Zeno

