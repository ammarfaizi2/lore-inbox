Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVFDAEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVFDAEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVFDAEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:04:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:32230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261183AbVFDAEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:04:12 -0400
Date: Fri, 3 Jun 2005 17:05:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-Id: <20050603170500.2ada62a2.akpm@osdl.org>
In-Reply-To: <42A0EDF9.5020908@pobox.com>
References: <42A0D88E.7070406@pobox.com>
	<20050603163843.1cf5045d.akpm@osdl.org>
	<42A0EDF9.5020908@pobox.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> >>
> >>So...  are we gonna see 2.6.12 sometime soon?
> >>
> > 
> > 
> > Current plan is -rc6 in a few days, 2.6.12 a week after that.
> 
> Cools.

hrm.

> 
> > My things-to-worry-about folder still has 244 entries.  Nobody seems to
> > care much.  Poor me.
> > 
> > Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
> > the usual suspects.
> 
> I've got a sata_sil oops fix coming.
> 

Cools.

> 
> > Subject: 2.6.12-rcx networking oops
> > Subject: [BUG] Lockup using ALi SATA controller (sata_uli)
> 
> does this have a bug# associated?
> 

Nope.  The simplest way to hunt these down is to stick the Subject into
double quotes and google it.

> 
> > Subject: [Bugme-new] [Bug 4297] New: VIA 82xxx sound problem with kernel
> > Subject: [Bugme-new] [Bug 4300] New: hpt366 S-ATA driver causes the kernel
> > Subject: [Bugme-new] [Bug 4368] New: b44 driver + udev: does not work if
> > Subject: [Bugme-new] [Bug 4374] New: bug in libata-core with sata_sil
> > Subject: [Bugme-new] [Bug 4380] New: via_velocity: receiver hang after
> > Subject: [Bugme-new] [Bug 4451] New: VIA Rhine II: media detection fails on
> > Subject: [Bugme-new] [Bug 4465] New: Problems with Intel ICH6-M Sonoma
> > Subject: [Bugme-new] [Bug 4551] New: pcnet32 don't follow module options
> 
> I'll take a look at these.

Thanks.

> Bug 4551 doesn't sound terribly urgent.
> 

Yeah, I need to do another pass through all the bugzilla entries.  Silly me
didn't realise that when you ask a question on bugzilla and the originator
replies, you don't get notified!  You have to manually add yourself to Cc.

That being said, managing these via bugzilla is nicer than via email. 
We'll get something better going post-2.6.12.

> 
> > Subject: Ooops: 0000 [#1] PIONEER DVD-RW DVR-K12RA
> 
> libata or IDE?
> 

http://www.google.com/search?hl=en&q=%220000+%5B%231%5D+PIONEER+DVD-RW+DVR-K12RA%22&btnG=Google+Search

> 
> > Subject: Oops in set_spdif_output in i810_audio
> > Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
> 
> I think this got sorted.

OK.

> > Subject: VIA interrupt quirk for 2.6.12?
> 
> I thought this had gotten sorted too.
> 

I think so too.

