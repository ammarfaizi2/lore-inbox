Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965413AbWJBVfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965413AbWJBVfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965417AbWJBVfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:35:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40905 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965413AbWJBVfU
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:35:20 -0400
Subject: Re: Postal 56% waits for flock_lock_file_wait
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Tim Chen <tim.c.chen@intel.com>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <20061002174039.GA17764@redhat.com>
References: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411>
	 <1159723092.5645.14.camel@lade.trondhjem.org>
	 <3282373b0610020957u739392eekf8b78c7574e1a6e7@mail.gmail.com>
	 <1159809081.5466.3.camel@lade.trondhjem.org>
	 <1159811516.8907.38.camel@localhost.localdomain>
	 <20061002174039.GA17764@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 23:00:36 +0100
Message-Id: <1159826436.8907.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 13:40 -0400, ysgrifennodd Dave Jones:
> On Mon, Oct 02, 2006 at 06:51:56PM +0100, Alan Cox wrote:
> "or similar" maybe. The iRam is pretty much junk in my experience[*].
> It rarely survives a mkfs, let alone sustained high throughput I/O.
> (And yes, I did try multiple DIMMs, including ones which survive
>  memtest86 just fine).

That appears to depend on the firmware and featureset used. With vaguely
recent firmware apart from the "failed diagnostics at boot" bug the one
I was loaned seems to be reliable and has fairly recent firmware.

> [*] And from googling/talking with other owners, my experiences aren't unique.

Agreed - even in windows 8)

Alan

