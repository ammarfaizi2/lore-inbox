Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbUDAUDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUDAUDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:03:54 -0500
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:28127 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S263097AbUDAUDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:03:51 -0500
Message-ID: <1080849830.91ac1e3f85274@system.cs.fsu.edu>
Date: Thu,  1 Apr 2004 15:03:50 -0500
From: khandelw@cs.fsu.edu
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.16
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.122.169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    When I compile the kernel2.4.16 and I get a kernel panic when I reboot the
m/c with the new kernel. I have a redhat 9.0 version and  when I use the
sources in the /usr/src/linux.x.x.x they work fine for me. by doing the nm
linux/vmlinux i get the EIP as c01070a6 and the function it points is
do_signal. I have sony vaio laptop 2.4 ghz, celeron.
    I need linux2.4.16 because i want to use LTT and the documentation of LTT
says that it can be used with that version. Can somebody gimme sm pointer
realted to this.

Thanks,
Amit Khandelwal



