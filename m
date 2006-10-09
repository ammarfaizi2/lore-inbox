Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWJIPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWJIPvG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWJIPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:51:05 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:59338 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751433AbWJIPvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:51:02 -0400
Date: Mon, 9 Oct 2006 16:51:00 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Steve Fox <drfickle@us.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Mel Gorman <mel@skynet.ie>,
       Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: 2.6.19-rc1: known regressions (v2) - xfrm_register_mode
In-Reply-To: <1160407954.1984.11.camel@flooterbu>
Message-ID: <Pine.LNX.4.64.0610091649300.5101@skynet.skynet.ie>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> 
 <20061007214620.GB8810@stusta.de> <1160407954.1984.11.camel@flooterbu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006, Steve Fox wrote:

> On Sat, 2006-10-07 at 23:46 +0200, Adrian Bunk wrote:
>> Subject    : oops in xfrm_register_mode
>> References : http://lkml.org/lkml/2006/10/4/170
>> Submitter  : Steve Fox <drfickle@us.ibm.com>
>> Status     : unknown
>
> Status: Vivek and Mel have both created patches which fix the boot
> issue, but it is not clear to me if either of these are acceptable
> fixes.
>

I suggest taking Vivek's.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
