Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279403AbRJ2Td0>; Mon, 29 Oct 2001 14:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279406AbRJ2TdQ>; Mon, 29 Oct 2001 14:33:16 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:57324 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S279403AbRJ2TdM>; Mon, 29 Oct 2001 14:33:12 -0500
Date: 27 Oct 2001 13:01:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8BfMOKoXw-B@khms.westfalen.de>
In-Reply-To: <3BD3FCD6.5010802@antefacto.com>
Subject: Re: [RFC] New Driver Model for 2.5
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <15uerh-0NbBEeC@fmrl04.sul.t-online.com> <15uerh-0NbBEeC@fmrl04.sul.t-online.com> <20011019122101.G2467@mikef-linux.matchmail.com> <8BEQdKdHw-B@khms.westfalen.de> <3BD3FCD6.5010802@antefacto.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

padraig@antefacto.com (Padraig Brady)  wrote on 22.10.01 in <3BD3FCD6.5010802@antefacto.com>:

> For ethernet cards (or anything else) on the PCI bus you can use
> the following to specify an order:
> ftp://platan.vc.cvut.cz/pub/linux/pciorder.patch-2.4.12-ac1.gz
> This allows you to pass the following parameter to the kernel:
> pciorder=Bus:Node.Fn,Bus:Node.Fn,... e.g.
> pciorder=0:0d.0,0:0b.0,0:0a.0

That doesn't look useful.

MfG Kai
