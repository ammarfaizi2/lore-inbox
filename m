Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310259AbSCPLXs>; Sat, 16 Mar 2002 06:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310272AbSCPLXh>; Sat, 16 Mar 2002 06:23:37 -0500
Received: from london-bridge.east.veritas.com ([207.30.27.2]:19534 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S310259AbSCPLXA>;
	Sat, 16 Mar 2002 06:23:00 -0500
Date: Sat, 16 Mar 2002 11:27:03 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Paul Mackerras <paulus@samba.org>
cc: Keith Owens <kaos@ocs.com.au>, Balbir Singh <balbir_soni@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules 
In-Reply-To: <15507.8527.952691.938382@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0203161126130.1090-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002, Paul Mackerras wrote:

> Keith Owens writes:
>
> > On Sat, 16 Mar 2002 09:51:16 +0000 (GMT),
> > <tigran@aivazian.fsnet.co.uk> wrote:
> > >jump to sys_nice() indirectly via exported sys_call_table[].
> >
> > Breaks on ia64 and ppc.
>
> Not that I want to encourage this sort of thing, but why would it
> break on ppc?

and also why would it break on ia64. I can understand __mips but why ia64?

Regards
Tigran

