Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTIWShw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTIWShv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:37:51 -0400
Received: from 217-124-19-167.dialup.nuria.telefonica-data.net ([217.124.19.167]:14734
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263411AbTIWShp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:37:45 -0400
Date: Tue, 23 Sep 2003 20:37:41 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Cc: Rafael Osuna <rosuna@wol.es>
Subject: Re: Ok, booting the kernel
Message-ID: <20030923183741.GA7119@localhost>
Mail-Followup-To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>,
	Rafael Osuna <rosuna@wol.es>
References: <200309231859.51228.rosuna@wol.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309231859.51228.rosuna@wol.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 23 September 2003, at 18:59:50 +0200,
Rafael Osuna wrote:

> I have my kernel compiled and working fine but I have had to chose the 386 
> option for the processor type. I have a Pentium 4 but when I compile the 
> kernel changing the processor type to "Pentium 4" (I don't change any other 
> parameter) and boot the computer with that kernel it hangs at the "Ok, 
> booting the kernel" step.
> 
> Has someone seen something like this?. Could you help me?
> 
Yes, if your are talking about kernel 2.6.0-testX there are already some 
million reports from people who forgot to include support for virtual
terminal and/or vga text console on their kernels.

If your problem is different, your kernel version another one, and have
more details about your problem just ask, but before do your homework
and search the list archives and Google.

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test5-mm3)
