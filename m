Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbTH0LUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTH0LUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:20:14 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:57605 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263321AbTH0LUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:20:11 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Yury Umanets <umka@namesys.com>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061964211.15513.41.camel@haron.namesys.com>
References: <20030826102233.GA14647@namesys.com>
	 <20030827055204.GA18114@cse.unsw.EDU.AU>
	 <1061964211.15513.41.camel@haron.namesys.com>
Content-Type: text/plain
Message-Id: <1061983191.678.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 13:19:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 08:03, Yury Umanets wrote:
> >  
> > Information: Reiser4 is going to be created on /dev/sda5.
> > (Yes/No): Yes
> > Creating reiser4 on /dev/sda5...
> > mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f7661
> > mkfs.reiser4(5676): unaligned access to 0x60000000000242fa, ip=0x20000000000f77a1
> > mkfs.reiser4(5676): unaligned access to 0x6000000000024302, ip=0x20000000000f78e1
> > mkfs.reiser4(5676): unaligned access to 0x60000000000242f2, ip=0x20000000000f2671
> > done
> > Synchronizing /dev/sda5...done
> 
> I will fix it soon.

Will Reiser4 be integrated into 2.6.0-test kernels anytime soon?
This would reduce time between releases and would open up it to a wider
audience for testing

