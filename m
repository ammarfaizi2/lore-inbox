Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUFJP5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUFJP5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUFJP5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:57:43 -0400
Received: from web90109.mail.scd.yahoo.com ([66.218.94.80]:48752 "HELO
	web90109.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S261724AbUFJP5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:57:41 -0400
Message-ID: <20040610155740.81227.qmail@web90109.mail.scd.yahoo.com>
Date: Thu, 10 Jun 2004 08:57:40 -0700 (PDT)
From: Kevin Tarr <kev_tarr@yahoo.com>
Subject: RE: Serial ATA (SATA) on Linux status report (2.6.x mainstream plan for AHCI and iswraid??)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine running with an ICH6R Intel chipset.
I've been watching the LKML for info on my ICH6R
chipset's AHCI mode support. It has been a month since
the last SATA status report so I figured I'd write to
ask: Does anyone know when the preliminary AHCI driver
will be integrated into libata mainline? If so I
assume it will be a patch against the 2.6.x kernel?

Also, are there plans to release a version of iswraid 
for ICH6R against 2.6.x?

Kevin Tarr

Jeff Garzik wrote:
> Serial ATA (SATA) for Linux
> status report
> May 10, 2004

> Intel ICH6 ("AHCI")
> -------------------
> Summary: Per-device queues, full SATA control
including > hotplug
> and PM.

> libata driver status: "looks like ICH5" support
available in ata_piix.
> Preliminary driver with full AHCI support now
exists, and is being
> integrated into libata mainline.



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
