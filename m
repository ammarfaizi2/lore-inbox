Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUDAJ46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbUDAJ46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:56:58 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:30216 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262329AbUDAJ45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:56:57 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Date: Thu, 1 Apr 2004 11:57:33 +0200
User-Agent: KMail/1.6.1
Cc: Bongani Hlope <bonganilinux@mweb.co.za>, Andrea Arcangeli <andrea@suse.de>
References: <20040331030921.GA2143@dualathlon.random> <20040331211620.19a8f725@bongani>
In-Reply-To: <20040331211620.19a8f725@bongani>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404011157.33051@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 21:16, Bongani Hlope wrote:

Hi Bongani,

> I'm running 2.6.5-rc2-aa4, when I woke-up in the morning almost all of my
> memory was gone, but my swap was never touched. I managed to get only the
> output of SysRq-M before it hard-locked. For some reason it doesn't swap.
> I'll try to reproduce.

hmm, I am running 2.6.5-rc3-aa1 stuff ontop of 2.6.5-rc3-mm3. It works very 
well. What is the value of /proc/sys/vm/swappiness?

ciao, Marc
