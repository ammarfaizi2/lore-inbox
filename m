Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVCDONE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVCDONE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVCDONE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:13:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15786 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262874AbVCDOMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:12:42 -0500
Date: Fri, 4 Mar 2005 15:12:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304141211.GC18335@suse.de>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <42268037.3040300@osdl.org> <Pine.LNX.4.62.0503041212580.2794@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503041212580.2794@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04 2005, Jesper Juhl wrote:
> I run vanilla kernels on all my boxes, workstations and
> servers, since I don't really trust vendor kernels.

That's a strange statement, I don't think you are aware of
the level of testing that goes into a vendor kernel, at
least for the 'enterprise' products. There's just no comparison
to the vanilla kernels.

Of course fixes get merged back into the vanilla kernels, but
these just don't have the lengthy test and maturity period
of vendor kernels (by a long stretch).

In fact the 2.6 cycle is specially geared towards vendor
stabilization. At some point this will slow down of course,
but I don't expect that to happen in the near future.

-- 
Jens Axboe

