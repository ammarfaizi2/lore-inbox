Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbUKOX1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUKOX1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKOX1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:27:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:43446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261626AbUKOX10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:27:26 -0500
Date: Mon, 15 Nov 2004 15:27:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2 doesn't boot
Message-ID: <20041115152721.U14339@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041115040710.GA2235@stusta.de> <Pine.LNX.4.58.0411142040470.2222@ppc970.osdl.org> <20041115052920.GB7510@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041115052920.GB7510@stusta.de>; from bunk@stusta.de on Mon, Nov 15, 2004 at 06:29:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> It seems Bjorns "PCI: remove unconditional PCI ACPI IRQ routing" was 
> merged now into your tree, but his patch to fix floppy.c wasn't 
> merged...

What's the likelihood of getting some derivative of Bjorn's patch
merged?  W/out the patch (and w/ floppy built) I've the same issue.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
