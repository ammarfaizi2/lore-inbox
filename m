Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbTG1Uwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTG1UwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:52:17 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:13279 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271038AbTG1Uuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:50:50 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Mike Dresser" <mdresser_l@windsormachine.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
Date: Mon, 28 Jul 2003 17:02:14 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGCEJCCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <1059423540.1257.0.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Thanks for your reply!  Later?  Could you be more specific?  What version?
Management is chomping at the bit here.  We have invested a lot of effort to
move to Linux and get away from Solaris!

Thanks for your help!
Kathy



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Monday, July 28, 2003 3:19 PM
To: Kathy Frazier
Cc: Mike Dresser; Linux Kernel Mailing List
Subject: RE: DMA not supported with Intel ICH4 I/O controller?


On Llu, 2003-07-28 at 22:02, Kathy Frazier wrote:
> 815E chipset (Pentium III) with an IHC2 I/O Controller Hub.  This is the
> system I did _all_ my stress testing in.  The plan was to ship our product
> with these ASUS P4PE MoBos (using Intel 845PE and ICH4 controller) and
were
> un-pleasantly surprise when it didn't work.

Later 2.4 supports ICH4 UDMA

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

