Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTINJQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 05:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTINJQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 05:16:26 -0400
Received: from mail3-126.ewetel.de ([212.6.122.126]:31941 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S262344AbTINJQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 05:16:25 -0400
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL  [was: Re: Driver Model]]
In-Reply-To: <vzkY.7cC.7@gated-at.bofh.it>
References: <vyRY.6te.13@gated-at.bofh.it> <vzkY.7cC.7@gated-at.bofh.it>
Date: Sun, 14 Sep 2003 11:16:13 +0200
Message-Id: <E19ySzN-0000Fr-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003 09:20:08 +0200, you wrote in linux.kernel:

> If one reads ./include/linux/module.h
> It clearly states any license is acceptable.

The problem is that the kernel has many copyright holders for different
parts of the code, so what the author of module.h wrote can well be
his own opinion but not that of others. Also, if modules are derived
works under the terms of the GPL, the header file cannot change that
fact, no matter what is says exactly.

Once again, it's all up to the lawyers to decide.

-- 
Ciao,
Pascal
