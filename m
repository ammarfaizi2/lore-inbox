Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbTIAWIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTIAWIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:08:13 -0400
Received: from h214n1fls32o988.telia.com ([62.20.176.214]:17078 "EHLO
	procyon.nix.homeunix.net") by vger.kernel.org with ESMTP
	id S263306AbTIAWIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:08:12 -0400
Date: Tue, 2 Sep 2003 00:08:10 +0200
From: Henrik Persson <nix@syndicalist.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: acme@conectiva.com.br, pclark@SLAC.Stanford.EDU,
       linux-kernel@vger.kernel.org
Subject: Re: orinoco wireless driver
In-Reply-To: <20030901230059.E22682@flint.arm.linux.org.uk>
References: <x34vfscwgq8.fsf@bbrcu5.slac.stanford.edu>
	<20030901174437.GK10584@conectiva.com.br>
	<20030901202251.066AD3FA2A@procyon.nix.homeunix.net>
	<20030901230059.E22682@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20030901220810.9B7B33FA2A@procyon.nix.homeunix.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 23:00:59 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> > And restart cardmgr a couple of times and then ejecting and
> > inserting.. Those procedures are needed here. ;)
> 
> Daniel Ritz was going to run some tests on his TI PCI1410 based laptop,
> but last I heard he didn't find anything wrong.  The mistery
> continues...
> 
> You might want to apply the patches on pcmcia.arm.linux.org.uk and see
> if any of those help (and say which one.)
> 
> Frankly, I don't see this issue getting resolved any time soon.

I've tried them all. No change.

It works pretty well in 2.4.21 though. I just have to eject and reinsert
in there to get it working. And there's still the issue that i have to
insert it twice before it's detected..

-- 
Henrik Persson  nix@syndicalist.net
