Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUHMTiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUHMTiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUHMTh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:37:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:21218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267338AbUHMTh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:37:29 -0400
Date: Fri, 13 Aug 2004 12:37:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Jens Axboe <axboe@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@www.pagan.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
In-Reply-To: <411D140C.4040100@pobox.com>
Message-ID: <Pine.LNX.4.58.0408131236340.1839@ppc970.osdl.org>
References: <1092313030.21978.34.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
 <1092341803.22458.37.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408121705050.1839@ppc970.osdl.org> <20040813065902.GB2321@suse.de>
 <1092383006.2813.0.camel@laptop.fenrus.com> <20040813074654.GA2663@suse.de>
 <411D140C.4040100@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Aug 2004, Jeff Garzik wrote:
>2B
> Jens Axboe wrote:
> > 
> > I have no idea how many apps use this ioctl, does anyone have a rough
> > list?
> 
> Add a rate-limited "this feature is deprecated" feature and find out...

Googling for it does show it as being documented and apparently used by a 
few programs, at least...

		Linus
