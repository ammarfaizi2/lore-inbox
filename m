Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbRCWWs0>; Fri, 23 Mar 2001 17:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131499AbRCWWsS>; Fri, 23 Mar 2001 17:48:18 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17681 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131489AbRCWWp3>; Fri, 23 Mar 2001 17:45:29 -0500
Subject: Re: Advansys SCSI driver old verson?
To: dougg@torque.net (Douglas Gilbert)
Date: Fri, 23 Mar 2001 22:46:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        icabod@lump.mine.nu (icabod)
In-Reply-To: <3ABBCE6C.8E71034@torque.net> from "Douglas Gilbert" at Mar 23, 2001 05:30:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gaKe-0005c8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andy Kellner (from ConnectCom Solutions formerly 
> known as Advansys) and Bob Frey (former maintainer) 
> working in concert have posted several "3.3x" versions 
> of the advansys driver to the linux-scsi list. Despite

I don't believe Linus reads linux-scsi. I only glance at it occasionally.
If you care to send me a diff against -ac23 I'll merge it and if it seems to
behave solidly then push it to Linus
