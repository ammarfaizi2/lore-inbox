Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267804AbTAHNvc>; Wed, 8 Jan 2003 08:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTAHNvc>; Wed, 8 Jan 2003 08:51:32 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:394
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267804AbTAHNvb>; Wed, 8 Jan 2003 08:51:31 -0500
Subject: Re: PROBLEM: 2.4.19 & 2.4.20 hang without oops...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: charlton@dynet.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107005229.A28504@bach.dynet.com>
References: <20030107005229.A28504@bach.dynet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042037129.24099.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 14:45:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 06:52, Charlton Harrison wrote:
> While attempting to copy about 50GB of data onto an NFS-mounted partition,
> the `cp -a` process will go for a while, then my machine will hang/freeze up.
> 
> I can reproduce it very easily and quickly on kernel 2.4.19 and 2.4.20,
> and most of the time happens before even copying 10GB worth of data.
> I am unable to reproduce the problem on kernel 2.4.18.
> 
> Here are the specifics:
> 
> HARDWARE:
> 
> Dual (SMP) P3-500,  supermicro MB,  512MB ECC buffered SDRAM.

What chipset is this system - is it 450NX by any chance ?

