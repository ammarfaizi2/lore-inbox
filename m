Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSKGQsm>; Thu, 7 Nov 2002 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbSKGQsm>; Thu, 7 Nov 2002 11:48:42 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:15002 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261462AbSKGQsl>; Thu, 7 Nov 2002 11:48:41 -0500
Message-ID: <5890690.1036687877193.JavaMail.nobody@web54.us.oracle.com>
Date: Thu, 7 Nov 2002 08:51:17 -0800 (PST)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: devilkin-lkml@blindguardian.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.44] Poweroff after warm reboot
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 29 October 2002 12:21, DevilKin wrote:
> > On Tuesday 29 October 2002 11:09, Jos Hulzink wrote:
> > > On Tuesday 29 October 2002 10:31, DevilKin wrote:
> > > > Hello,
> > > >
> > > > If I reboot my laptop with kernel 2.5.44 (warm reboot), the machine
> > > > reboots, loads the kernel, and then in the middle of the booting
> > > > process powers off.
> > >
> > > Hmm... maybe it has something to do with ACPI ? Could you try booting the
> > > kernel after a warm reboot with ACPI disabled ?
> >
> > It's APM, not ACPI (luckely :oP)
> This problem is still present with 2.5.45 and 2.5.46.

<AOL>same here</AOL>

Actually I haven't tested further kernels than 2.5.45 as I just spent the night moving
 files from the laptop that suffered, alas, uncorrectable drive errors. Luckily the only
 file lost was linux-2.5.45.tar :) I only hope that the poweroffs didn't help the drive
 to die earlier than it should have :/

--alessandro
