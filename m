Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSCWBWj>; Fri, 22 Mar 2002 20:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310783AbSCWBPY>; Fri, 22 Mar 2002 20:15:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S293175AbSCWBPJ>;
	Fri, 22 Mar 2002 20:15:09 -0500
Date: Fri, 22 Mar 2002 22:32:54 GMT
Message-Id: <200203222232.g2MMWsY02827@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Steffen Persvold <sp@scali.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupts lost on Intel Plumas chipset
In-Reply-To: <3C9BAB3D.C66B7AAE@scali.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C9BAB3D.C66B7AAE@scali.com> you wrote:
> List readers,
> 
> I have a SuperMicro P4DPR+ system here with Dual Intel Xeon 1.7GHz. This board utilizes the Intel
> E7500 (Plumas) chipset. The chipset is configured with two P64H2 (PCI-X) Hubs, one which is
> kernel-2.4.9-21smp (and I've also tried a stock 2.4.17 kernel), interrupts from the SCI card never

You need at least kernel-2.4.9-31smp or 2.4.18 for the plumas chipset to
work properly
