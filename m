Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbQJ0RQG>; Fri, 27 Oct 2000 13:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbQJ0RPw>; Fri, 27 Oct 2000 13:15:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61295 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129215AbQJ0RPm>; Fri, 27 Oct 2000 13:15:42 -0400
Subject: Re: VM-global-2.2.18pre17-7
To: jeff@aslab.com (Jeff Nguyen)
Date: Fri, 27 Oct 2000 18:16:46 +0100 (BST)
Cc: vherva@mail.niksula.cs.hut.fi (Ville Herva), linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
In-Reply-To: <008e01c0402c$85369760$7818b7c0@aslab.com> from "Jeff Nguyen" at Oct 27, 2000 08:42:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pD7X-0004fZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should use the Intel e100 driver at
> http://support.intel.com/support/network/adapter/pro100/100Linux.htm.
> It works much better than eepro100.

Thats not the general consensus, but its worth trying in case it works best
for a given problem. In paticular it knows about bugs with combinations of
transceivers which the eepro100 driver does not.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
