Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVGYTeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVGYTeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVGYTeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:34:08 -0400
Received: from totor.bouissou.net ([82.67.27.165]:15004 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261491AbVGYTcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:32:10 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Date: Mon, 25 Jul 2005 21:31:56 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507251500270.8043-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507251500270.8043-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507252131.56826@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 25 Juillet 2005 21:18, Alan Stern a écrit :
>
> > 6/ Unplugged the mouse, then:
> > - rmmod ehci-hcd
> > - rmmod uhci-hcd
> > - modprobe ehci-hcd
>
> Do you really mean "modprobe ehci-hcd" here?  So the EHCI driver was
> loaded and not the UHCI driver?  Or was that a typo?

Sorry, typo, the copy/paste artifact syndrom :-(

I meant uhci, as you guessed...

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
