Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310248AbSCPLIt>; Sat, 16 Mar 2002 06:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSCPLIi>; Sat, 16 Mar 2002 06:08:38 -0500
Received: from mail.bstc.net ([63.90.24.2]:59663 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S310249AbSCPLIc>;
	Sat, 16 Mar 2002 06:08:32 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.8527.952691.938382@argo.ozlabs.ibm.com>
Date: Sat, 16 Mar 2002 21:41:19 +1100 (EST)
To: Keith Owens <kaos@ocs.com.au>
Cc: tigran@aivazian.fsnet.co.uk, Balbir Singh <balbir_soni@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules 
In-Reply-To: <15852.1016272812@ocs3.intra.ocs.com.au>
In-Reply-To: <Pine.LNX.4.33.0203160950120.936-100000@euler24.homenet>
	<15852.1016272812@ocs3.intra.ocs.com.au>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> On Sat, 16 Mar 2002 09:51:16 +0000 (GMT), 
> <tigran@aivazian.fsnet.co.uk> wrote:
> >jump to sys_nice() indirectly via exported sys_call_table[].
> 
> Breaks on ia64 and ppc.

Not that I want to encourage this sort of thing, but why would it
break on ppc?

Paul.
