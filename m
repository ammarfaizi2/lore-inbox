Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUHFBHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUHFBHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 21:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUHFBHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 21:07:09 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39359 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268042AbUHFBE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 21:04:59 -0400
Subject: Re: [PATCH] (IDE) restore access to low order LBA following error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brett Russ <russb@emc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <4112BF1E.9070404@pobox.com>
References: <41126458.1050203@emc.com>
	 <1091724300.8043.58.camel@localhost.localdomain>
	 <4112BF1E.9070404@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091750465.8366.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 06 Aug 2004 01:01:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 00:13, Jeff Garzik wrote:
> Alan Cox wrote:
> > Once Jeff has MWDMA and ATAPI in the new SATA/ATA driver he wrote then
> > migration might be an even better option. It'll certainly be easier to
> > do a lot of things right with the newest SATA code than with the current
> > IDE layer.
> BTW MWDMA is already done and checked in :)

Do ATAPI and I'll be glad to help move the other drivers over. I need
hotplug for my PIIX controller and SI680!

