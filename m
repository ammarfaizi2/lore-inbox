Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTAJQbR>; Fri, 10 Jan 2003 11:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbTAJQbR>; Fri, 10 Jan 2003 11:31:17 -0500
Received: from [207.61.129.108] ([207.61.129.108]:28859 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S265400AbTAJQbN>; Fri, 10 Jan 2003 11:31:13 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Date: Fri, 10 Jan 2003 11:39:57 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301101139.57342.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There will be a new kernel tree that will fit this purpose soon called -xlk 
(eXtendable or Extended Linux Kernel). The hope to make it an 'official' like 
-ac, -mm tree for stuffing experimental stuff into a post 2.6 (or just before 
2.6 goes live) kernel. I will need help in getting this to become a reality 
in the coming months to 2.6.

The purpose of the tree is to get experimental code ready for the 2.7 (2.9?) 
tree. We want code that will add new drivers / devices and general 
improvements to the kernel. The goal is once these are stabilized they can be 
submitted to Linus and friends for blessings and inclusion into 2.7 dev 
*early* so we won't have a mad rush for features before the next feature 
freeze.

>Subject:  any chance of 2.6.0-test*?
From:     William Lee Irwin III <wli () holomorphy ! com>
>Date:     2003-01-10 16:10:12

>Say, I've been having _smashing_ success with 2.5.x on the desktop and
>on big fat highmem umpteen-way SMP (NUMA even!) boxen, and I was
>wondering if you were considering 2.6.0-test* anytime soon.

>I'd love to get this stuff out for users to hammer on ASAP, and things
>are looking really good AFAICT.

>Any specific concerns/issues/wishlist items you want taken care of
>before doing it or is it a "generalized comfort level" kind of thing?
>Let me know, I'd be much obliged for specific directions to move in.


>Thanks,
>Bill
 
-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

