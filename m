Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbWCCW1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWCCW1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWCCW1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:27:25 -0500
Received: from mail.dvmed.net ([216.237.124.58]:43158 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751698AbWCCW1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:27:24 -0500
Message-ID: <4408C2CA.5010909@garzik.org>
Date: Fri, 03 Mar 2006 17:27:22 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Leech <christopher.leech@intel.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
References: <20060303214036.11908.10499.stgit@gitlost.site>
In-Reply-To: <20060303214036.11908.10499.stgit@gitlost.site>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech wrote:
> This patch series is the first full release of the Intel(R) I/O
> Acceleration Technology (I/OAT) for Linux.  It includes an in kernel API
> for offloading memory copies to hardware, a driver for the I/OAT DMA memcpy
> engine, and changes to the TCP stack to offload copies of received
> networking data to application space.
> 
> These changes apply to DaveM's net-2.6.17 tree as of commit
> 2bd84a93d8bb7192ad8c23ef41008502be1cb603 ([IRDA]: TOIM3232 dongle support)
> 
> They are available to pull from
> 	git://198.78.49.142/~cleech/linux-2.6 ioat-2.6.17
> 
> There are 8 patches in the series:
> 	1) The memcpy offload APIs and class code
> 	2) The Intel I/OAT DMA driver (ioatdma)

Patch #2 didn't make it.  Too big for the list?

	Jeff



