Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbRBWGOd>; Fri, 23 Feb 2001 01:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbRBWGOX>; Fri, 23 Feb 2001 01:14:23 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:59652 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131491AbRBWGOJ>; Fri, 23 Feb 2001 01:14:09 -0500
Date: Fri, 23 Feb 2001 00:14:02 -0600
To: Peter Bergner <bergner@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Boot log for Linux PPC64 on POWER3 hardware
Message-ID: <20010223001402.A19464@cadcamlab.org>
In-Reply-To: <3A95AB71.FCECB41F@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A95AB71.FCECB41F@us.ibm.com>; from bergner@us.ibm.com on Thu, Feb 22, 2001 at 06:14:41PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Peter Bergner]
> The following is a boot log for a 64 bit port of Linux for IBM's 64
> bit PowerPC processors.  This log was made on a pSeries model 270
> which uses a POWER3 microprocessor.

Impressive.  One question, though --

> starting cpu /cpus/PowerPC,POWER3@1...ok
> starting cpu /cpus/PowerPC,POWER3@2...ok
> starting cpu /cpus/PowerPC,POWER3@3...ok

You have 4 CPUs?

> OpenPIC Version 1.2 (8 CPUs and 32 IRQ sources) at e000000001002000
> OpenPIC timer frequency is 0 MHz

...or is it 8 CPUs?

> swamsauger:~ # uname -a
> Linux swamsauger 2.4.0-tg11 #188 Thu Feb 22 19:55:45 CST 2001 ppc64 unknown
> swamsauger:~ # 
> swamsauger:~ # cat /proc/cpuinfo 
> processor       : 0

...or just one CPU?

Peter
(And when do we get XFree86 support for the GXT-2000P, -3000P etc?)
