Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVCTJcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVCTJcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 04:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVCTJcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 04:32:35 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:38123 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262059AbVCTJcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 04:32:23 -0500
Subject: Re: bcm203x broadcom dongle firmware upload fails...
From: Soeren Sonnenburg <kernel@nn7.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1111257144.9930.5.camel@pegasus>
References: <1111244625.6115.6.camel@localhost>
	 <1111257144.9930.5.camel@pegasus>
Content-Type: text/plain
Date: Sun, 20 Mar 2005 10:32:13 +0100
Message-Id: <1111311133.6115.13.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-19 at 19:32 +0100, Marcel Holtmann wrote:
> Hi Soeren,

[firmware upload not working]
> > It does not work with kernel 2.6.10/11 any ideas ?
> 
> I think this is a general request_firmware() problem. Check the Hotplug
> mailing list archive. Hannes, Kay and Greg discussed problems with the
> firmware_class and udev. I haven't found the time to look at it.

Just for reference that is the link to their thread form March 15:
http://sourceforge.net/mailarchive/message.php?msg_id=11165076

If it is an udev issue it would explain why the dongle was working when
plugged in before the booting the machine.

If there is a patch flying around that is supposed to fix this issue,
please let me know!

Best,
Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

