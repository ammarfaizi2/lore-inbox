Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270727AbTG1UZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270816AbTG1UZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:25:07 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:38397 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270727AbTG1UZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:25:04 -0400
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kathy Frazier <kfrazier@mdc-dayton.com>
Cc: Mike Dresser <mdresser_l@windsormachine.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <PMEMILJKPKGMMELCJCIGIEIMCDAA.kfrazier@mdc-dayton.com>
References: <PMEMILJKPKGMMELCJCIGIEIMCDAA.kfrazier@mdc-dayton.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059423540.1257.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 21:19:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-28 at 22:02, Kathy Frazier wrote:
> 815E chipset (Pentium III) with an IHC2 I/O Controller Hub.  This is the
> system I did _all_ my stress testing in.  The plan was to ship our product
> with these ASUS P4PE MoBos (using Intel 845PE and ICH4 controller) and were
> un-pleasantly surprise when it didn't work.

Later 2.4 supports ICH4 UDMA

