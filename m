Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTIPNw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbTIPNw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:52:27 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:59141 "EHLO
	sparc1.karlsbakk.net") by vger.kernel.org with ESMTP
	id S261297AbTIPNw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:52:26 -0400
Subject: Re: [BUG] 2.4.2(2|3-pre4)? error with ICH5
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1063719740.10793.3.camel@roy-sin>
References: <1063719740.10793.3.camel@roy-sin>
Content-Type: text/plain
Organization: ProntoTV AS
Message-Id: <1063720321.10787.6.camel@roy-sin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 16 Sep 2003 15:52:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> using an ICH5 SATA (raid?) controller with two non-raid drives. During
> boot, it hangs after the following messages:
> 
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xc000-0xc007,0xc402 on irq 5
> ide3 at 0xc800-0xc807,0xcc02 on irq 5
> hde: attached ide-disk driver
> 
> that's a hard hang, and alt+sysrq won't let me do anything about it :(
> 
> any ideas?

I forgot to tell: It works fine with 2.4.20. Haven't tried other
kernels.

roy

