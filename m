Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVGKVD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVGKVD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVGKVAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:00:24 -0400
Received: from totor.bouissou.net ([82.67.27.165]:5814 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262669AbVGKU65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:58:57 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 22:58:53 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507111611470.6399-100000@iolanthe.rowland.org> <200507112246.48069@totor.bouissou.net>
In-Reply-To: <200507112246.48069@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507112258.53906@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 22:46, Michel Bouissou a écrit :
>
> Well, this time, I deactivated the mouse in BIOS, rebooted again, also with
> "usb-handoff", and "again it works"...

...at least, it worked until I unplugged my USB scanner...

Jul 11 22:52:54 totor kernel: usb 3-2: USB disconnect, address 2

...then replugged my USB scanner...

Jul 11 22:53:08 totor kernel: usb 3-2: new full speed USB device using 
uhci_hcd and address 3
Jul 11 22:53:08 totor kernel: irq 21: nobody cared!

Oh no :-(

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
