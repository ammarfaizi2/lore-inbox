Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVCVDKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVCVDKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVCVCoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:44:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262281AbVCVCDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:03:23 -0500
Date: Mon, 21 Mar 2005 21:02:58 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, rjw@sisk.pl, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322020258.GC19541@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
	rjw@sisk.pl, linux-kernel@vger.kernel.org,
	"Brown, Len" <len.brown@intel.com>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org> <20050322004456.GB1372@elf.ucw.cz> <20050321170623.4eabc7f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321170623.4eabc7f8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 05:06:23PM -0800, Andrew Morton wrote:

 > # drivers/pci/pci-acpi.c
 > #   2005/03/19 00:15:24-05:00 len.brown@intel.com +46 -1
 > #   add platform_pci_choose_state()
 > # 
 > diff -Nru a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
 > --- a/drivers/pci/pci-acpi.c	2005-03-21 17:01:44 -08:00
 > +++ b/drivers/pci/pci-acpi.c	2005-03-21 17:01:44 -08:00
 > @@ -1,6 +1,6 @@
 >  /*
 >   * File:	pci-acpi.c
 > - * Purpose:	Provide PCI support in ACPI
 > + * Purpose:	Provde PCI support in ACPI

Oops.

		Dave

