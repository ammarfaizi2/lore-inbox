Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRCNSEI>; Wed, 14 Mar 2001 13:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131486AbRCNSD6>; Wed, 14 Mar 2001 13:03:58 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:37639
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S131484AbRCNSDx>; Wed, 14 Mar 2001 13:03:53 -0500
Date: Wed, 14 Mar 2001 13:03:10 -0500
From: Chris Mason <mason@suse.com>
To: "Manfred H. Winter" <mahowi@gmx.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
cc: ReiserFS Mailing List <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] [2.4.3-pre2] Crash (Perhaps reiserfs?)
Message-ID: <1286210000.984592990@tiny>
In-Reply-To: <20010313202455.A752@marvin.mahowi.de>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, March 13, 2001 08:24:55 PM +0100 "Manfred H. Winter"
<mahowi@gmx.net> wrote:

> Hi!
> 
> A few minutes ago, my system crashed on Linux 2.4.3-pre2. I attach the
> log of the crash and what ksymoops says about it.


Hmm, oops looks bogus, and the trace in the log file has some symbols
missing.  I think you should turn off the symbol translation in klogd, and
give the pure oops to ksymoops.

-chris

