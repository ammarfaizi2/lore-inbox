Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTFBD45 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 23:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTFBD45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 23:56:57 -0400
Received: from web14006.mail.yahoo.com ([216.136.175.122]:53307 "HELO
	web14006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261807AbTFBD44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 23:56:56 -0400
Message-ID: <20030602041020.77468.qmail@web14006.mail.yahoo.com>
Date: Sun, 1 Jun 2003 21:10:20 -0700 (PDT)
From: Matt Hartley <matthartley@yahoo.com>
Subject: Re: [PATCH] linux-2.4.21-rc5-ac2
To: alan@lxorguk.ukuu.org.uk, xose@wanadoo.es, lkml@lpbproductions.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054309256.23566.49.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all for the comments.  I went through my original patch and
added  everything to the PCI IDs database that was in the kernel and
not in the database already.  Fortunately, there weren't too many.

Thanks again!
Matt Hartley


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2003-05-30 at 09:33, Matt Hartley wrote:
> > Alan,
> > 
> > After noticing that drivers/pci/pci.ids was over nine months old, I
> > grabbed the latest list off of http://pciids.sourceforge.net,
> modded it
> > to include a few recent submissions and to fix a couple of broken
> > lines, and created this patch. 
> 
> Mostly merged - dropped a couple of bits where it backed out kernel
> changes that seem to have failed to reach the master list
> 


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
