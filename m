Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUFCPOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUFCPOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265543AbUFCPNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:13:44 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:54656 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S265541AbUFCPG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:06:28 -0400
Date: Thu, 3 Jun 2004 10:06:11 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Sebastian <sebastian@expires0604.datenknoten.de>
cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange DMA-errors and system hang with SMART (was: ...and system
 hang with Promise 20268)
In-Reply-To: <1086202839.4439.11.camel@coruscant.datenknoten.de>
Message-ID: <Pine.GSO.4.21.0406031002060.5907-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry for my late reply, too. I had been out of country and away from
> Internet.

No problem.

> > I hadn't realized until now that the drive is an IBM GXP60.
> > 
> > smartctl is *supposed* to print a warning message for these drives, to
> > tell users to look at http://www.geocities.com/dtla_update/index.html#rel
> > for pointers to updated firmware for this drive!  What firmware version do
> > you have?
> 
> Yes, the warning is there. However, there never had been a problem with
> it for years until I upgraded the kernel. I probably should have paid
> more attention to that warning... The problem is that most of the links
> are broken on the page that you refer to.

Indeed, you are right.  Try this:

http://www-3.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-42215


