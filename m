Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVCJHyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVCJHyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 02:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVCJHyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 02:54:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:15306 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262206AbVCJHyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 02:54:37 -0500
Subject: Re: 2.6.11-mm2 + Radeon crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Henz <christian.henz@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <493984f050309121212541d8@mail.gmail.com>
References: <493984f050309121212541d8@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 18:49:02 +1100
Message-Id: <1110440942.32525.218.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 21:12 +0100, Christian Henz wrote:
> Hi, 
> 
> I wanted to try 2.6.11-mm2 for the low latency/realtime lsm stuff and
> I've run into a severe
> problem.
> 
> When I try to start X, my machine reboots. The screen goes dark as
> usual when setting the video mode, but then I get a beep and I'm
> greeted with the BIOS boot messages. This happened 4/5 times i've
> tried, and once the video mode was actually set (at least I saw the
> usual X b/w pattern with some random framebuffer garbage), the machine
> didn't reboot but after that nothing happened. My keyboard was still
> responsive (ie NumLock LED would still go on/off), but i could neither
> kill X with CTRL-ALT-BACKSPACE nor could i switch back to console, so
> I ended up pressing reset.
> 
> After the crashes I booted with a rescue CD to examine the logs, but I
> could not find any obvious errors.
> 
> Everything works nicely on 2.6.10 and earlier kernels. I'm in the
> process of building 2.6.11.2 to see if the crash occurs there.

So ?

Ben.


