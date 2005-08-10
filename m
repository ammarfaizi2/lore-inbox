Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVHJWwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVHJWwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVHJWwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:52:13 -0400
Received: from dvhart.com ([64.146.134.43]:20098 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932576AbVHJWwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:52:13 -0400
Date: Wed, 10 Aug 2005 15:52:10 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: abonilla@linuxwireless.org,
       "'Jon Scottorn'" <jscottorn@possibilityforge.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Kernel panic 2.6.12.4
Message-ID: <1271950000.1123714330@flay>
In-Reply-To: <005d01c59de0$c08a2040$a20cc60a@amer.sykes.com>
References: <005d01c59de0$c08a2040$a20cc60a@amer.sykes.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>    I am in need of some help!
>> I have installed Debian which has 2.6.8-2 kernel on it.  After a fresh
>> install I downloaded the 2.6.12.4 kernel and went to upgrade.  After
>> making the necessary changes in menuconfig I rebuilt the kernel and
>> install it.  It boots up until I get:
>> Modules linked in:
>> CPU:       0
>> EIP:         0060:[c026d55d]   Not tainted VLI
>> EFLAGS: 00010006    (2.6.12.4)
>> EIP is at adpt_isr+0x178/0x1f5
>> .......
>> Cut out for space and time as I am typeing it all in.
>> ........
>> <0>Kernel panic - not syncing: Fatal exception in interrupt
>> 
>> Any help would be greatly appreciated.
>> I have been messing with this issue for the past 3 days now.  I have
>> tried 2.6.11, 2.6.11.11, 2.6.12, 2.6.12.3, 2.6.12.4 and all of those
>> kernels end up with the same problem.
>> 
>> Thanks in advance.
>> 
>> Jon
> 
> AFAIK, you have to be in Debian Sid to use 2.6.13 as the base system needs
> some updates. Anyway, your /usr/src/linux-2.6.12-4/.config will be required
> to know if you are doing something wrong...

Sarge works fine.

M.

