Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTDCVNV 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263511AbTDCVNU 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:13:20 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:44682 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S263508AbTDCVNS 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 16:13:18 -0500
Date: Thu, 3 Apr 2003 23:25:16 +0200 (CEST)
From: Stephan van Hienen <raid@a2000.nu>
To: Ezra Nugroho <ezran@goshen.edu>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RAID 5 performance problems
In-Reply-To: <1049403752.22426.5146.camel@ezran.goshen.edu>
Message-ID: <Pine.LNX.4.53.0304032323580.6681@ddx.a2000.nu>
References: <Pine.GSO.4.30.0304030858080.20118-100000@multivac.sdsc.edu> 
 <Pine.LNX.4.53.0304032104070.3085@ddx.a2000.nu> <1049403752.22426.5146.camel@ezran.goshen.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Ezra Nugroho wrote:

> What should I expect from a 8 drive raid 5 on 3ware 7500-8?
> I get only
> /dev/sda:
>  Timing buffer-cache reads:   128 MB in  0.74 seconds =172.97 MB/sec
>  Timing buffered disk reads:  64 MB in  1.55 seconds = 41.29 MB/sec
>
> which seems to be slow compared to the numbers above

I think you should look at the '3ware bad write speed' thread on
linux-raid
looks like you are running in 3ware raid mode ?
