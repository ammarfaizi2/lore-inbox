Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRH3PcI>; Thu, 30 Aug 2001 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272279AbRH3Pbs>; Thu, 30 Aug 2001 11:31:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38928 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272269AbRH3Pbg>; Thu, 30 Aug 2001 11:31:36 -0400
Subject: Re: EISA irq probing problem (ESIC chip)
To: bgerst@didntduck.org (Brian Gerst)
Date: Thu, 30 Aug 2001 16:35:10 +0100 (BST)
Cc: Bart.Vandewoestyne@pandora.be (Bart Vandewoestyne),
        linux-kernel@vger.kernel.org
In-Reply-To: <3B8E55F3.EA83A325@didntduck.org> from "Brian Gerst" at Aug 30, 2001 11:04:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cTqY-0001GF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Out of curiosity, have you tried a recent -ac kernel with PnP BIOS
> enabled?  EISA devices might possibly show up there.

I believe EISA bios services are different
