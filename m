Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965423AbWJBVk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965423AbWJBVk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965424AbWJBVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:40:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965423AbWJBVkY (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:40:24 -0400
Date: Mon, 2 Oct 2006 17:40:12 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Tim Chen <tim.c.chen@intel.com>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Postal 56% waits for flock_lock_file_wait
Message-ID: <20061002214012.GC9854@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Tim Chen <tim.c.chen@intel.com>,
	"Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
References: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411> <1159723092.5645.14.camel@lade.trondhjem.org> <3282373b0610020957u739392eekf8b78c7574e1a6e7@mail.gmail.com> <1159809081.5466.3.camel@lade.trondhjem.org> <1159811516.8907.38.camel@localhost.localdomain> <20061002174039.GA17764@redhat.com> <1159826436.8907.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159826436.8907.77.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 11:00:36PM +0100, Alan Cox wrote:
 > Ar Llu, 2006-10-02 am 13:40 -0400, ysgrifennodd Dave Jones:
 > > On Mon, Oct 02, 2006 at 06:51:56PM +0100, Alan Cox wrote:
 > > "or similar" maybe. The iRam is pretty much junk in my experience[*].
 > > It rarely survives a mkfs, let alone sustained high throughput I/O.
 > > (And yes, I did try multiple DIMMs, including ones which survive
 > >  memtest86 just fine).
 > 
 > That appears to depend on the firmware and featureset used. With vaguely
 > recent firmware apart from the "failed diagnostics at boot" bug the one
 > I was loaned seems to be reliable and has fairly recent firmware.

Mine was latest hardware (rev 1.3), and there wasn't any firmware update
available that I could see. :-/

 > > [*] And from googling/talking with other owners, my experiences aren't unique.
 > Agreed - even in windows 8)

It's amazing crap like this reaches the store shelves.

	Dave

-- 
http://www.codemonkey.org.uk
