Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTA1X5n>; Tue, 28 Jan 2003 18:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTA1X5n>; Tue, 28 Jan 2003 18:57:43 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262089AbTA1X5m>;
	Tue, 28 Jan 2003 18:57:42 -0500
Subject: Re: 2.5.59-dcl2
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1043794298.10153.241.camel@dell_ss3.pdx.osdl.net>
References: <1043794298.10153.241.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043798822.10150.318.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 16:07:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missed one item in the credits.

Also, added the Nick Piggin's anticipaatory i/o scheduler (via -mm5)
to 2.5.59-dcl2 to evaluate the performance impact under different loads.


> 2.5.59-osdl2:
> . Dac960 error retry                    (Dave Olien)
> 
> 2.5.59-dcl2:
> . Lost timer tick compensation          (John Stultz)
> . Improved boot time TSC synchronization (Jim Houston)
> . Lockless gettimeofday                 (Andi Kleen, me)
> . Performance monitoring counters for x86 (Mikael Pettersson)
> 
> 2.5.59-osdl1:
> . Bug fix for vmlinux.ld.S		(Kai Germaschewski)
> . Update to LKCD for multiple schemes   (Bharata B Rao)
> . Bug fixes for LKCD locking            (me)
> . Improved i386 fatal event notifiers   (me)
> . Kprobe using notify_die               (me)
> 
> 2.5.59-dcl1:
> .  RCU statistics                   (Dipankar Sarma)
> .  Scheduler tunables               (Robert Love)


