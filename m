Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272320AbSISTCb>; Thu, 19 Sep 2002 15:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272334AbSISTCb>; Thu, 19 Sep 2002 15:02:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:25746 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S272320AbSISTCb>; Thu, 19 Sep 2002 15:02:31 -0400
Date: Thu, 19 Sep 2002 12:05:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Bond, Andrew" <Andrew.Bond@hp.com>, linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
Message-ID: <434201548.1032437133@[10.10.2.3]>
In-Reply-To: <45B36A38D959B44CB032DA427A6E106402D09E42@cceexc18.americas.cpqcorp.net>
References: <45B36A38D959B44CB032DA427A6E106402D09E42@cceexc18.americas.cpqcorp.net>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we have gotten better performance by patching the kernel?  Sure.  There are many new features in 2.5 that would enhance database performance.  However, the fairly strict support requirements of TPC benchmarking mean that we need to benchmark a kernel that a Linux distributor ships and can support.  
> Modifications could also be taken to the extreme, and we could have built a screamer kernel that runs Oracle TPC-C's and nothing else.  However, that doesn't really tell us anything useful and doesn't help those customers thinking about running Linux.  The question also becomes "Who would provide customer support for that kernel?" 

Unofficial results for 2.5 vs 2.4 (or 2.4-redhatAS) would be most
interesting if you're able to gather them, and still have the
machine. Most times you can avoid their draconian rules by saying
"on a large benchmark test that I can't name but you all know what
it is ..." instead of naming it ... ;-)

M.

