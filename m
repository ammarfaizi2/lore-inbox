Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285457AbRLGKa4>; Fri, 7 Dec 2001 05:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285459AbRLGKas>; Fri, 7 Dec 2001 05:30:48 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:18446 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S285457AbRLGKac>;
	Fri, 7 Dec 2001 05:30:32 -0500
Date: Fri, 7 Dec 2001 10:33:11 +0000
From: Ian Molton <spyro@armlinux.org>
To: linux-kernel@vger.kernel.org
Subject: Bug?
Message-Id: <20011207103311.386e54fe.spyro@armlinux.org>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Havent had time to investigate, but I have seen a locup on the ASUS A7M
mobo, with a via-rhine (100Mb/se, fdx) ethernet card.

With the ethernet card in one PCI slot, the USB (95% of the time) will
freeze the system solid when usb-uhci.o is loaded.

Since moving the card to another slot, it seems to works fine.

if anyone suggests 'things to look for' I will have a look (but it isnt my
box, so it may take time).

For reference, I have a (similar) box with the same CPU and mobo, but
different cards, and have never seen this (or any similar) lockup.

the mobo in the machine in question has been replaced, and the replacement
shows the same problem.
