Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274037AbRI0W5m>; Thu, 27 Sep 2001 18:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274031AbRI0W5f>; Thu, 27 Sep 2001 18:57:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30226 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274053AbRI0W5A>; Thu, 27 Sep 2001 18:57:00 -0400
Subject: Re: megaraid driver only seeing 2 of 3 logical dirve.
To: Atulm@ami.com (Atul Mukker.)
Date: Fri, 28 Sep 2001 00:02:02 +0100 (BST)
Cc: balbert@internet.com ('Byron Albert'), linux-kernel@vger.kernel.org
In-Reply-To: <1355693A51C0D211B55A00105ACCFE6402D2601A@ATL_MS1> from "Atul Mukker." at Sep 27, 2001 03:37:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mkAM-0005PO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The driver you are using seems to be not what we had released ( as I could
> make out from the dmesg ) . Which distribution/kernel are you using. I
> recommend you to get 1.17c, which is the latest driver. I will mail it
> separately to you since sending attachments on this list is probably not a
> good idea

1.17a is the last release that went into the mainstream, then updated to
1.17a-ac to fix a tiny problem with HP controllers (the fix I then sent back
on upstream)


If 1.17c is recommended you might want to send Linus and I an update
