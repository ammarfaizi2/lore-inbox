Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267362AbTBFQ5L>; Thu, 6 Feb 2003 11:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267364AbTBFQ5L>; Thu, 6 Feb 2003 11:57:11 -0500
Received: from franka.aracnet.com ([216.99.193.44]:38322 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267362AbTBFQ5K>; Thu, 6 Feb 2003 11:57:10 -0500
Date: Thu, 06 Feb 2003 09:06:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc -O2 vs gcc -Os performance
Message-ID: <233640000.1044551189@[10.10.2.4]>
In-Reply-To: <1044553691.10374.20.camel@irongate.swansea.linux.org.uk>
References: <336780000.1044313506@flay>  <224770000.1044546145@[10.10.2.4]> <1044553691.10374.20.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> All done with gcc-2.95.4 (Debian Woody). These machines (16x NUMA-Q) have 
>> 700MHz P3 Xeons with 2Mb L2 cache ... -Os might fare better on celeron 
>> with a puny cache if someone wants to try that out
> 
> gcc 3.2 is a lot smarter about -Os and it makes a very big size
> difference according to the numbers the from the ACPI guys.
> 
> Im not sure testing with a gcc from the last millenium is useful 8)

I'll retest with gcc-3.2 ... maybe it'll finally show a case where it's
better than 2.95 this way?

<ducks> <runs>

M.

