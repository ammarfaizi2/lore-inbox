Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVCDT3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVCDT3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbVCDT2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:28:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:36833 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263016AbVCDTOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:14:42 -0500
Date: Fri, 4 Mar 2005 11:14:29 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304191429.GA30241@kroah.com>
References: <20050303151752.00527ae7.akpm@osdl.org> <1109894511.21781.73.camel@localhost.localdomain> <20050303182820.46bd07a5.akpm@osdl.org> <1109933804.26799.11.camel@localhost.localdomain> <20050304032820.7e3cb06c.akpm@osdl.org> <1109940685.26799.18.camel@localhost.localdomain> <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org> <Pine.LNX.4.58.0503041020130.25732@ppc970.osdl.org> <20050304183804.GB29857@kroah.com> <4228B02A.8010202@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228B02A.8010202@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:59:54AM -0800, Randy.Dunlap wrote:
> 
> Can/will/should it also include *required* (showstopper) build fixes,
> if there are any of those?

I think so, the ppc fix is such a thing.  But not for things marked
CONFIG_BROKEN :)

thanks,

greg k-h
