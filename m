Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWB1P1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWB1P1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWB1P1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:27:36 -0500
Received: from xenotime.net ([66.160.160.81]:43450 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932169AbWB1P1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:27:35 -0500
Date: Tue, 28 Feb 2006 07:27:32 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: Pavel Machek <pavel@ucw.cz>, Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 7/13] ATA ACPI: more Makefile/Kconfig
In-Reply-To: <44043C18.2070502@pobox.com>
Message-ID: <Pine.LNX.4.58.0602280727090.30832@shark.he.net>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
 <20060222135802.60ab42ab.randy_d_dunlap@linux.intel.com> <20060228114915.GC4081@elf.ucw.cz>
 <44043C18.2070502@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Jeff Garzik wrote:

> Pavel Machek wrote:
> > On St 22-02-06 13:58:02, Randy Dunlap wrote:
> >
> >>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> >>
> >>Simplify Makefile.
> >>Add Kconfig help.
> >
> >
> > Could you fold this with patch 1 of series? Introducing too complex
> > Makefile then fixing it makes review quite "interetsing".
>
> Agreed.  Patches should be folded together...

Agreed.  and I'll rename the config option as well....

-- 
~Randy
