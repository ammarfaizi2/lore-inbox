Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266792AbUHIRlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266792AbUHIRlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUHIRlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:41:20 -0400
Received: from expredir2.cites.uiuc.edu ([128.174.5.185]:48297 "EHLO
	expredir2.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S266792AbUHIRlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:41:18 -0400
From: Paul Miller <paul-kernel@pinheiro.dyndns.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: sysfs / udev programming faq/howto?
Date: Mon, 9 Aug 2004 12:41:13 -0500
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091241.13882.paul-kernel@pinheiro.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,  I'm somewhat new to Linux kernel programming.  I've made a few 
drivers for custom/embedded hardware, etc with kernel 2.4 and kernel 2.6 
w/ devfs, but I'm a little lost working with sysfs and udev.

All I want to do is have udev register my character device for a custom 
PCI board.  Is there a FAQ that explains this?   Does udev need to be 
configured to look for my device?  Currently, I have it registering with 
sysfs as a pci driver and it shows up under /sys/bus/pci/drivers.

Thanks,
-Paul
