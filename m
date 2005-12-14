Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVLNWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVLNWaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVLNWaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:30:55 -0500
Received: from xenotime.net ([66.160.160.81]:59362 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965018AbVLNWax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:30:53 -0500
Date: Wed, 14 Dec 2005 14:30:52 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: linux-kernel@vger.kernel.org
cc: lkml@rtr.ca, axboe@suse.de, jgarzik@pobox.com, pavel@suse.cz,
       mm-commits@vger.kernel.org
Subject: Re: + libata_acpi.patch added to -mm tree
In-Reply-To: <200512142152.jBELqLF9007622@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0512141427090.29143@shark.he.net>
References: <200512142152.jBELqLF9007622@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005 akpm@osdl.org wrote:

> The patch titled
>
>      libata acpi support
>
> has been added to the -mm tree.  Its filename is
>
>      libata_acpi.patch
>
> From: Author unknown...

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>

> Stolen from Mark Lord's site at
> http://rtr.ca/dell_i9300/kernel/kernel-2.6.15/.

or http://www.xenotime.net/linux/SATA/2.6.15-rc/

> NFI what this does, but it looks cool.

Adds support for ACPI suspend/resume methods for SATA drives.

> Cc: Mark Lord <lkml@rtr.ca>
> Cc: Pavel Machek <pavel@suse.cz>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: Jens Axboe <axboe@suse.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

-- 
~Randy
