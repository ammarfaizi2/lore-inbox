Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUGIOVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUGIOVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUGIOVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:21:36 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53909 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264919AbUGIOVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:21:34 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: ncunningham@linuxmail.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] swsusp bootsplash support
Date: Fri, 9 Jul 2004 16:27:11 +0200
User-Agent: KMail/1.5.3
Cc: Pavel Machek <pavel@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       Erik Rigtorp <erik@rigtorp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040708110549.GB9919@linux.nu> <20040709115531.GA28343@redhat.com> <1089375589.3001.7.camel@nigel-laptop.wpcb.org.au>
In-Reply-To: <1089375589.3001.7.camel@nigel-laptop.wpcb.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407091627.11515.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Friday 09 of July 2004 14:19, Nigel Cunningham wrote:
> Hi.
>
> On Fri, 2004-07-09 at 21:55, Dave Jones wrote:
> > Personally I'd prefer the effort went into making suspend actually
> > work on more machines rather than painting eyecandy for the minority
> > of machines it currently works on.
>
> That's happening. I'm hoping to merge Suspend2 within the week. It has
> support for SMP, Highmem (4GB), preempt, PPC (courtesy Steve & Ben),
> X86-64 (being finished by 'Disconnect' right now), x86, image
> compression and bootsplash. An NFS image writer is also planned.

Can I find suspend2 broken on individual patches somewhere?

