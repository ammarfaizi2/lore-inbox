Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266328AbUFPV7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUFPV7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266330AbUFPV6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:58:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266328AbUFPV6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:58:35 -0400
Date: Wed, 16 Jun 2004 17:58:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andre Tomt <andre@tomt.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Programtically tell diff between HT and real
In-Reply-To: <40D0BD42.1090007@tomt.net>
Message-ID: <Pine.LNX.4.53.0406161754260.852@chaos>
References: <20040616174646.70010.qmail@web51805.mail.yahoo.com> 
 <1087408567.7869.1.camel@localhost> <1087411607.7869.3.camel@localhost>
 <Pine.LNX.4.53.0406161644450.541@chaos> <40D0BD42.1090007@tomt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Andre Tomt wrote:

> Richard B. Johnson wrote:
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> >   mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> >                                                            ^_______
> > bogomips	: 5570.56
> >
> > I would love to know how you turn in on! This is one of those
> > "latest-and-greatest" Intel D865PERL mother-boards and I've
> > even flashed the BIOS with the "latest-and-greatest".
>
> The usual way is to enable HT in BIOS, and use a SMP enabled kernel.
>

It's a SMP kernel. There is no 'HT enable' in the BIOS setup.
In fact, there is very little that can be set and, it's even
very hard to convince it that I want to boot from a SCSI and
not from the first disk it finds. One has to remove the battery
to discharge the CMOS so it won't ignore the 'Del' key
on startup. It's a very bad BIOS or a very bad board, I
don't know which.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


