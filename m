Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUIIOiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUIIOiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUIIOiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:38:01 -0400
Received: from open.hands.com ([195.224.53.39]:35796 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S264953AbUIIOfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:35:03 -0400
Date: Thu, 9 Sep 2004 15:46:15 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  patch)
Message-ID: <20040909144615.GA7292@lkcl.net>
References: <20040909114747.GC30162@lkcl.net> <20040909134614.GB27983@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909134614.GB27983@harddisk-recovery.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 03:46:14PM +0200, Erik Mouw wrote:

> > all their code is GPL.  this is very cool.
> 
> Most of their code is not GPL'ed. It does have a COPYING file, but that
> looks like a BSD license to me. The only (implicitly) GPL'ed part is
> the ALSA patch.
 
 well, better than nothing.

> > it is available here:
> > 
> > 	http://www.smlink.com/main/down/slmodem-2.9.9.tar.gz
> > 
> > i trust that someone will download, check it, and if
> > appropriate, incorporate it into the mainstream linux kernel.
> 
> It's not a GPL driver, the kernel part contains a binary object file
> (drivers/amrlibs.o) so I don't see how it can be included in the main
> kernel tree. 

 DRAT.

> OTOH, at first glance only the PCI driver needs that
> binary blob, the USB driver doesn't.

 ah ha!

 i sent them a message, see if they react well to licensing the
 rest as GPL.

 l.

