Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTJ1WYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJ1WYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:24:17 -0500
Received: from be.zoznam.sk ([62.65.179.8]:52655 "EHLO be1.mail.zoznam.sk")
	by vger.kernel.org with ESMTP id S261772AbTJ1WYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:24:08 -0500
Date: Tue, 28 Oct 2003 23:20:54 +0100
From: Jakub Krajcovic <news.receive@zoznam.sk>
To: linux-kernel@vger.kernel.org
Subject: Floppy in 2.6
Message-Id: <20031028232054.1d452baa.news.receive@zoznam.sk>
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody, this might be a stupid question, but here goes anyway:

I've been using the 2.6 test kernels from when -test4 was released, but only today have i noticed that my floppy drive is nowhere to be found.

I've checked the in the menu for the kernel config (make menuconfig) and i did not find the  "block devices > normal floppy support" option (as it was called in the 2.4 kernels) anywhere, and there is no /dev/fd0 on my system.

In 2.4 there was the option for "normal floppy support" and I have the /dev/fd0 device for my floppy when I boot the old 2.4.22 kernel. So my question is: does the 2.6 kernel support normal floppy disks or not? And if it does, how do I enable this support in order to use my floppy drive.

thanx in advance

