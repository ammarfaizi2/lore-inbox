Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFDJPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFDJPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 05:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVFDJPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 05:15:52 -0400
Received: from c64.shuttle.de ([194.95.226.64]:51075 "EHLO c64.shuttle.de")
	by vger.kernel.org with ESMTP id S261304AbVFDJPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 05:15:46 -0400
X-Virus-Check: ClamAV 0.85.1/911 on c64.shuttle.de; Sat, 04 Jun 2005 11:15:45 +0200
Date: Sat, 4 Jun 2005 11:15:45 +0200
From: Frank Elsner <frank@moltke28.B.Shuttle.DE>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11:   kernel BUG at fs/jbd/checkpoint.c:247!
In-Reply-To: <20050603163356.5e7fc472.akpm@osdl.org>
References: <E1DeJTR-00026k-5j@moltke28.B.Shuttle.DE>
	<20050603163356.5e7fc472.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1DeUkr-000555-PI@moltke28.B.Shuttle.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005 16:33:56 -0700 Andrew Morton <akpm@osdl.org> wrote:
> Frank Elsner <frank@moltke28.B.Shuttle.DE> wrote:
> >
> > Jun  3 04:04:54 seymour kernel: kernel BUG at fs/jbd/checkpoint.c:247!
> 
> We're hoping that this is fixed now.  How repeatable is it for you?

I fear I can't reproduce it. 
It occured for the first time since I'm runnning linux-2.6.11. 
I'm now using linux-2.6.11.11. 

> Please test
> 
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.12-rc5.tar.bz2
> plus
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc5-git8.bz2

Thanks for dealing with the problem and the hint(s).

I don't understand the current numbering scheme. 
Is linux-2.6.12-rcX better than linux-2.6.11.xx?
Linux-2.6.12-rcX is 3 days older than linux-2.6.11.11!

Shall I go to linux-2.6.12-rcX or stay with linux-2.6.11.11?


--Frank
