Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFCXz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFCXz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFCXz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:55:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39104 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261152AbVFCXzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:55:45 -0400
Message-ID: <42A0EDF9.5020908@pobox.com>
Date: Fri, 03 Jun 2005 19:55:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org>
In-Reply-To: <20050603163843.1cf5045d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>
>>So...  are we gonna see 2.6.12 sometime soon?
>>
> 
> 
> Current plan is -rc6 in a few days, 2.6.12 a week after that.

Cools.


> My things-to-worry-about folder still has 244 entries.  Nobody seems to
> care much.  Poor me.
> 
> Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
> the usual suspects.

I've got a sata_sil oops fix coming.


> Subject: 2.6.12-rcx networking oops
> Subject: [BUG] Lockup using ALi SATA controller (sata_uli)

does this have a bug# associated?


> Subject: [Bugme-new] [Bug 4297] New: VIA 82xxx sound problem with kernel
> Subject: [Bugme-new] [Bug 4300] New: hpt366 S-ATA driver causes the kernel
> Subject: [Bugme-new] [Bug 4368] New: b44 driver + udev: does not work if
> Subject: [Bugme-new] [Bug 4374] New: bug in libata-core with sata_sil
> Subject: [Bugme-new] [Bug 4380] New: via_velocity: receiver hang after
> Subject: [Bugme-new] [Bug 4451] New: VIA Rhine II: media detection fails on
> Subject: [Bugme-new] [Bug 4465] New: Problems with Intel ICH6-M Sonoma
> Subject: [Bugme-new] [Bug 4551] New: pcnet32 don't follow module options

I'll take a look at these.

Bug 4551 doesn't sound terribly urgent.


> Subject: Ooops: 0000 [#1] PIONEER DVD-RW DVR-K12RA

libata or IDE?


> Subject: Oops in set_spdif_output in i810_audio
> Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?

I think this got sorted.

> Subject: VIA interrupt quirk for 2.6.12?

I thought this had gotten sorted too.

	Jeff


