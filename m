Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUGOGTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUGOGTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUGOGTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:19:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266128AbUGOGSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:18:47 -0400
Message-ID: <40F621B9.7020407@pobox.com>
Date: Thu, 15 Jul 2004 02:18:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: augustus@linuxhardware.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Via Velocity Concerns
References: <Pine.LNX.4.58.0407142336280.7017@penguin.linuxhardware.org>
In-Reply-To: <Pine.LNX.4.58.0407142336280.7017@penguin.linuxhardware.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

augustus@linuxhardware.org wrote:
> I am testing the via velocity gigabit ethernet drivers in the 2.6.8-rc1 
> kernel.  It seems to work fine unless it is compiled into the kernel.  If 
> it is compiled in then it kernel panics as soon as it tries to bring up 
> the device with dhcpcd.  If you load the driver as a module though, all is 
> fine.

Try the updated velocity driver in Andrew's -mm tree.

	Jeff



