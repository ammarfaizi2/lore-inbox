Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTDULum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTDULum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:50:42 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:32128 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263818AbTDULul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:50:41 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304211204.h3LC4VA6000616@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 21 Apr 2003 13:04:31 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), vda@port.imtp.ilyichevsk.odessa.ua,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030421130341.06d60830.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 21, 2003 01:03:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Name an IDE or SCSI disk on sale today that doesn't retry on write
> > failiure.  Forget I said 'Generally do'.
> 
> IBM DMVS18V (SCSI)
> Maxtor ATA133 160 GB DiamondMax Plus.
> 
> Maybe they _should_, but I can tell you they in fact sometimes don't
> (IBM very, very seldom, Maxtor just about all the time)

How do you know those disks don't retry on write failiure?  How do you
know they aren't retrying and failing?

> How do _you_ know that? What makes _you_ argue for what _I_ think is
> useful and _my_ sense of security? You are on thin ice ...

Linux is an open source operating system, you are welcome to add the
feature if you want it.

> > We have moved on since the 1980s, and I believe that it is now up to
> > the drive firmware, or the block device driver to do this, it has no
> > place in a filesystem.
> 
> Interestingly I owned one of those 30 MB MFM Seagate howling drives
> back in the 80s. I had no errors on it until I threw it away for its
> unbelievable noise rate. Today I throw away one (very low-noise)
> disk about every week for shooting yet another fs somewhere near
> midnight.
> Indeed we moved on, only the direction looks sometimes questionable ...

Ask the disk manufacturers for advice.

John.
