Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUGEVPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUGEVPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUGEVPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:15:37 -0400
Received: from fmr11.intel.com ([192.55.52.31]:29097 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262356AbUGEVPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:15:34 -0400
Subject: Re: 2.6.7-mm3 USB ehci IRQ problem
From: Len Brown <len.brown@intel.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1089059612.3589.5.camel@paragon.slim>
References: <A6974D8E5F98D511BB910002A50A6647615FEF3E@hdsmsx403.hd.intel.com>
	 <1089054167.15653.51.camel@dhcppc4>  <1089058581.2496.9.camel@paragon.slim>
	 <1089059612.3589.5.camel@paragon.slim>
Content-Type: text/plain
Organization: 
Message-Id: <1089062128.15675.122.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 17:15:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 16:33, Jurgen Kramer wrote:
> On Mon, 2004-07-05 at 22:16, Jurgen Kramer wrote:
> > On Mon, 2004-07-05 at 21:02, Len Brown wrote:
> > > On Sun, 2004-06-27 at 08:02, Jurgen Kramer wrote:

> 2.6.7 vanilly results are in. The results are...it works..

great!  Now if you can apply this patch to 2.6.7 and tell me if
it is ACPI that broke EHCI for you in -mm5 or something else:

http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm5/broken-out/bk-acpi.patch


thanks,
-Len


