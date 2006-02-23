Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWBWA2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWBWA2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWBWA2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:28:33 -0500
Received: from xenotime.net ([66.160.160.81]:41963 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751602AbWBWA2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:28:32 -0500
Date: Wed, 22 Feb 2006 16:28:31 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Andrew Morton <akpm@osdl.org>
cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH 0/13] ACPI objects for SATA/PATA
In-Reply-To: <20060222162654.31ef25ad.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0602221627160.24281@shark.he.net>
References: <20060222141238.4d2effa8.randy_d_dunlap@linux.intel.com>
 <20060222162654.31ef25ad.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Andrew Morton wrote:

> Randy Dunlap <randy_d_dunlap@linux.intel.com> wrote:
> >
> > This patch series is primarily ACPI objects support for SATA/PATA.
> > It applies to 2.6.16-rc4.
>
> I tried to get these on top of Jeff's current devel tree but gave up at
> ata-acpi-pata-methods when things got really sticky.
>
> So you're rather between a rock and a hard place here.  Perhaps it would be
> better for you to continue development on top of Jeff's devel tree, and to
> distribute a copy of git-libata-all.patch along with your patches to your
> testers.
>
> Of course, that puts them on the bleeding edge when all they want to do is
> to get their power management working, so that's not really suitable
> either.

OK, I'll think about how to attack that...
Thanks for the info.  I didn't think about you using git-libata*.
My bad.

-- 
~Randy
