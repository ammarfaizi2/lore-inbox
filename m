Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271400AbTG2LHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTG2LHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:07:13 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:41199 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271400AbTG2LHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:07:10 -0400
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kathy Frazier <kfrazier@mdc-dayton.com>
Cc: Mike Dresser <mdresser_l@windsormachine.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <PMEMILJKPKGMMELCJCIGCEJCCDAA.kfrazier@mdc-dayton.com>
References: <PMEMILJKPKGMMELCJCIGCEJCCDAA.kfrazier@mdc-dayton.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059442100.1868.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 12:01:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-28 at 23:02, Kathy Frazier wrote:
> Alan,
> 
> Thanks for your reply!  Later?  Could you be more specific?  What version?
> Management is chomping at the bit here.  We have invested a lot of effort to
> move to Linux and get away from Solaris!

2.4.20 or later should do it. Red Hat 9 current errata, probably the current errata 
kernels of other vendors too.

hdparm -d /dev/hda will tell you

