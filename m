Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbULFBdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbULFBdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 20:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULFBdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 20:33:14 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:5562 "EHLO mgr2.xmission.com")
	by vger.kernel.org with ESMTP id S261447AbULFBdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 20:33:11 -0500
Message-ID: <41B3B6D7.2000000@xmission.com>
Date: Sun, 05 Dec 2004 18:33:11 -0700
From: maxer <maxer@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sk98lin.ko Marvell ethernet gigabit lan fails in 2.6.9, 2.6.8 kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 166.70.55.125
X-SA-Exim-Mail-From: maxer@xmission.com
X-SA-Exim-Version: 4.0 (built Sat, 24 Apr 2004 12:31:30 +0200)
X-SA-Exim-Scanned: Yes (on mgr1.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SysKonnect Marvell Gigabit lan seems to have been lost in the kernel 
shuffle from 2.6.6 or 2.6.7.

Has the maintainer dropped the ball on this?

The module has never gone through any name change:
/lib/modules/2.6.9/kernel/drivers/net/sk98lin/sk98lin.ko

I have dowloaded the patch from SysKonnect
http://www.syskonnect.com/syskonnect/support/driver/d0102_driver.html

There are instructions for patching the sk98in driver.

I have successfully patched updated the driver and currently have it 
working in 2.6.9

Who is the kernel maintainer for this?  Why hasn't the patch listed 
above and dated October 20, 2004 been incorporated?

Thanks,

RaXeT
