Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264433AbRGEOU5>; Thu, 5 Jul 2001 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRGEOUr>; Thu, 5 Jul 2001 10:20:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29962 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264433AbRGEOUg>; Thu, 5 Jul 2001 10:20:36 -0400
Date: Thu, 5 Jul 2001 16:20:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Manfred H. Winter" <mahowi@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705162035.Q17051@athlon.random>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>; from mahowi@gmx.net on Wed, Jul 04, 2001 at 11:28:17PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2001 at 11:28:17PM +0200, Manfred H. Winter wrote:
> Hi!
> 
> I tried to install kernel 2.4.6 with same configuration as 2.4.5, but
> booting failed with:
> 
> kernel BUG at softirq.c:206!

do you have any problem with those patches applied?

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_ksoftirqd-7
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre5aa1/00_softirq-fixes-4

Andrea
