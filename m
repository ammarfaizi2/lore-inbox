Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132036AbRA2Pcl>; Mon, 29 Jan 2001 10:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbRA2Pcc>; Mon, 29 Jan 2001 10:32:32 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:41185 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132036AbRA2PcN>; Mon, 29 Jan 2001 10:32:13 -0500
Message-ID: <3A758CE7.F152869F@Home.net>
Date: Mon, 29 Jan 2001 10:31:51 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM?] PCI Probe failing? 2.4.x kernels
In-Reply-To: <Pine.LNX.4.10.10101290836100.26212-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bleh, too bad you can't flash onboard chipsets ;/

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II]
(rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II]

Mark Hahn wrote:

> > Limiting direct PCI/PCI transfers.
> >
> > What does this mean?
>
> it's a chipset bug that the kernel works around.
> nothing to do with the previous message.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
