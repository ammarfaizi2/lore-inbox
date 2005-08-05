Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVHEJzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVHEJzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVHEJzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:55:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30346 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262944AbVHEJxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:53:31 -0400
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:
	nobody cared!"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Fieroch <Fieroch@web.de>, jesper.juhl@gmail.com,
       bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       B.Zolnierkiewicz@elka.pw.edu.pl, adobriyan@gmail.com,
       Natalie.Protasevich@UNISYS.com
In-Reply-To: <20050804132516.2f468522.akpm@osdl.org>
References: <d6gf8j$jnb$1@sea.gmane.org>
	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>
	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>
	 <20050615143039.24132251.akpm@osdl.org>
	 <1118960606.24646.58.camel@localhost.localdomain> <42B2AACC.7070908@web.de>
	 <1119011887.24646.84.camel@localhost.localdomain> <42B302C2.9030009@web.de>
	 <9a874849050617101712b80b15@mail.gmail.com> <42C0953B.8000506@web.de>
	 <20050804132516.2f468522.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 11:19:02 +0100
Message-Id: <1123237142.19745.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-04 at 13:25 -0700, Andrew Morton wrote:
> OK, that's the driver which Alan played with.  I don't expect we'll be able
> to get all this fixed up for 2.6.13.
> 
> Please check 2.6.13-rc6 when it's out - this might fix the IRQ problem.  If
> any bugs remain, please raise entries for them at bugzilla.kernel.org,
> thanks.

I've been following his reports for a while and its IRQ routing without
much doubt.

