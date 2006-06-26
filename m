Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWFZOax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWFZOax (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWFZOax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:30:53 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:15262 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1030225AbWFZOaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:30:52 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606261424.k5QEOolI013449@wildsau.enemy.org>
Subject: Re: finding pci_dev from scsi_device
In-Reply-To: <1151332173.3185.46.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Date: Mon, 26 Jun 2006 16:24:50 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > > can you share with us what you want to do with this?
> > 
> > I need the pci_dev to reconfigure ahci-controllers so that they look like
> > having been initialised by BIOS at reboot time.
> 
> isn't it better to do this in the ahci driver itself instead?

guess what I'm doing.

> it for sure will be orders of magnitude easier....

yes?
 
