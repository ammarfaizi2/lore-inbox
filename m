Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSF0IAr>; Thu, 27 Jun 2002 04:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSF0IAq>; Thu, 27 Jun 2002 04:00:46 -0400
Received: from happy.kiev.ua ([193.109.241.145]:45581 "EHLO happy.kiev.ua")
	by vger.kernel.org with ESMTP id <S316649AbSF0IAp>;
	Thu, 27 Jun 2002 04:00:45 -0400
Date: Thu, 27 Jun 2002 11:00:19 +0300
From: Pavel Gulchouck <gul@gul.kiev.ua>
To: James Stevenson <mistral@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel crash
Message-ID: <20020627080019.GA30350@happy.kiev.ua>
Reply-To: gul@gul.kiev.ua
References: <20020626110230.GA21100@happy.kiev.ua> <008901c21d44$231e5fd0$0501a8c0@Stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008901c21d44$231e5fd0$0501a8c0@Stev.org>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux
X-FTN-Address: 2:463/68
X-Flames-To: /dev/null
X-GC: GCC d- s+: a31 C+++ UL++++ UB P+ L++ E--- W++ N++ o-- K- w--- O++
X-GC: M? V- PS PE+ Y+ PGP+ t? 5? X? R? !tv b+ DI? D? G e h--- r+++ y+++
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi!

On Wed, Jun 26, 2002 at 08:03:20PM +0100, James Stevenson writes:

> > Jun 20 04:33:30 gate kernel: ------------[ cut here ]------------
> > Jun 20 04:33:30 gate kernel: kernel BUG at inode.c:1066!
> > Jun 20 04:33:30 gate kernel: invalid operand: 0000
> > Jun 20 04:33:30 gate kernel: ip_nat_ftp ipt_REJECT ipt_REDIRECT cls_u32 sch_tbf sch_cbq autofs smbfs ne2k-p
> > Jun 20 04:33:30 gate kernel: CPU:    0
> > Jun 20 04:33:31 gate kernel: EIP:    0010:[iput+47/496]    Tainted: P
> > Jun 20 04:33:31 gate kernel: EIP:    0010:[<c0148cdb>]    Tainted: P
> > Jun 20 04:33:31 gate kernel: EFLAGS: 00010286
> 
> what makes your kernel tainted ?

It's a question for me.

> do you have some binary only drivers ?

No.

-- 
                                Lucky carrier,
                                                  Pavel.
