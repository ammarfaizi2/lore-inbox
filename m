Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSHWXwq>; Fri, 23 Aug 2002 19:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSHWXwq>; Fri, 23 Aug 2002 19:52:46 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:19419 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S314278AbSHWXwp>; Fri, 23 Aug 2002 19:52:45 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDD2@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Brueggeman, Steve'" <steve_brueggeman@xiotech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Anyone know how to get soft-power-down to work on an Intel SC
	B2??
Date: Fri, 23 Aug 2002 16:56:41 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Brueggeman, Steve [mailto:steve_brueggeman@xiotech.com] 
> Their documentation says they support soft-power-off, but I 
> certainly cannot
> figure out how to do it.
> 
> The SCB2 only has one processor, and the kernel is compiled for single
> processor.   I've enabled APM and ACPI, and the exact same 
> binaries (kernel
> and modules) work on 4 different machines, and do 
> soft-power-off them, and
> one of them WAS a dual processor system.
> 
> So, I'm hoping that someone out there has figured out this problem.
> 
> I've even tried the patches for acpi on sourceforge.net.  
> They didn't help,
> and seemed to make the kernel MUCH more flakey (got illegal ioctl when
> trying to mount a loopback device)

We talking 2.4 or 2.5 here?

Please send me the output from dmesg. I have an SCB2 sitting 15 feet away
from me and haven't seen the problems you're running into.

> I'd appreciate it if you copied me on any responses, as I 
> currently am not
> subscribed to the kernel mailing list, (because I don't have 
> POP/SMTP access
> at work.  (M.S. Exchange house and all....)

Well I have to use Exchange, and I get about 10 mailing lists, so it is
possible.

Regards -- Andy
