Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVB0Pp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVB0Pp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 10:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVB0Pp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 10:45:29 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:56333 "EHLO
	globaledgesoft.com") by vger.kernel.org with ESMTP id S261405AbVB0PpY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 10:45:24 -0500
Message-ID: <4221E981.10004@globaledgesoft.com>
Date: Sun, 27 Feb 2005 21:08:41 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: problem between audio driver and mmc driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 172.16.6.42
X-Return-Path: krishna.c@globaledgesoft.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a strange problem.
The Audio driver is statically compiled into the kernel.

When I am loading my MMC driver, It is getting Audio Interrupts.

I browsed thru the web and found out it is a bug in the hardware.

The hardware bug is preventing Audio driver and MMC driver work 
simultaneously.
Does any one have a solution Or a Work around to make both the drivers 
work though the audio driver
is statically compiled into the kernel.

Regards,
Krishna Chaitanya

