Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUGIMZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUGIMZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 08:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUGIMZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 08:25:24 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:23513 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S266155AbUGIMZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 08:25:23 -0400
Subject: Re: [PATCH] swsusp bootsplash support
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dave Jones <davej@redhat.com>
Cc: Pavel Machek <pavel@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       Erik Rigtorp <erik@rigtorp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040709115531.GA28343@redhat.com>
References: <20040708110549.GB9919@linux.nu>
	 <20040708133934.GA10997@infradead.org>
	 <20040708204840.GB607@openzaurus.ucw.cz>
	 <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz>
	 <20040708225501.GA20143@infradead.org> <20040709051528.GB23152@elf.ucw.cz>
	 <20040709115531.GA28343@redhat.com>
Content-Type: text/plain
Message-Id: <1089375589.3001.7.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 09 Jul 2004 22:19:49 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-09 at 21:55, Dave Jones wrote:
> Personally I'd prefer the effort went into making suspend actually
> work on more machines rather than painting eyecandy for the minority
> of machines it currently works on.

That's happening. I'm hoping to merge Suspend2 within the week. It has
support for SMP, Highmem (4GB), preempt, PPC (courtesy Steve & Ben),
X86-64 (being finished by 'Disconnect' right now), x86, image
compression and bootsplash. An NFS image writer is also planned.

Regards,

Nigel

