Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275995AbRI1S3j>; Fri, 28 Sep 2001 14:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276022AbRI1S32>; Fri, 28 Sep 2001 14:29:28 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:3547 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S275995AbRI1S3T>;
	Fri, 28 Sep 2001 14:29:19 -0400
Date: Fri, 28 Sep 2001 11:37:08 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adding a printk in start_secondary breaks 2.4.10, not 2.4.9 ??
Message-ID: <949648833.1001677028@[10.10.1.2]>
In-Reply-To: <E15n24b-0007tz-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect the panic has nothing to do with adding the printk, but merely
> that the timing patterns of your disgusting hack have changed
>
> Happy logical analysers 8)

But this printk breaks a standard SMP machine without my patches (well,
just this tiny printk part), not just the NUMA boxes ....

M.



