Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVHJTWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVHJTWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVHJTWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:22:05 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:46047
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1030212AbVHJTWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:22:04 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Jon Scottorn'" <jscottorn@possibilityforge.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Kernel panic 2.6.12.4
Date: Wed, 10 Aug 2005 13:21:46 -0600
Message-ID: <005d01c59de0$c08a2040$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <42FA5082.8080907@possibilityforge.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
>
>    I am in need of some help!
> I have installed Debian which has 2.6.8-2 kernel on it.  After a fresh
> install I downloaded the 2.6.12.4 kernel and went to upgrade.  After
> making the necessary changes in menuconfig I rebuilt the kernel and
> install it.  It boots up until I get:
> Modules linked in:
> CPU:       0
> EIP:         0060:[c026d55d]   Not tainted VLI
> EFLAGS: 00010006    (2.6.12.4)
> EIP is at adpt_isr+0x178/0x1f5
> .......
> Cut out for space and time as I am typeing it all in.
> ........
> <0>Kernel panic - not syncing: Fatal exception in interrupt
>
> Any help would be greatly appreciated.
> I have been messing with this issue for the past 3 days now.  I have
> tried 2.6.11, 2.6.11.11, 2.6.12, 2.6.12.3, 2.6.12.4 and all of those
> kernels end up with the same problem.
>
> Thanks in advance.
>
> Jon

AFAIK, you have to be in Debian Sid to use 2.6.13 as the base system needs
some updates. Anyway, your /usr/src/linux-2.6.12-4/.config will be required
to know if you are doing something wrong...

Does this also occur with a custom 2.6.8 kernel?

.Alejandro

