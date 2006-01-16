Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWAPPs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWAPPs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWAPPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:48:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37032 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751031AbWAPPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:48:27 -0500
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jgarzik <jgarzik@pobox.com>
In-Reply-To: <20060116123112.GZ3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
	 <20060116123112.GZ3945@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 15:51:50 +0000
Message-Id: <1137426710.15553.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-16 at 13:31 +0100, Jens Axboe wrote:
> On Fri, Jan 13 2006, Randy.Dunlap wrote:
> > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > 
> > Add ata_acpi in Makefile and Kconfig.
> > Add ACPI obj_handle.
> > Add ata_acpi.c to libata kernel-doc template file.
> 
> Randy,
> 
> Any chance you can add PATA support as well for this? 

It should just work with pata devices using libata.

Alan

