Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbRA3BL7>; Mon, 29 Jan 2001 20:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131753AbRA3BLu>; Mon, 29 Jan 2001 20:11:50 -0500
Received: from cc399455-a.chmchl1.ca.home.com ([65.0.176.232]:17427 "EHLO
	polaris.wox.org") by vger.kernel.org with ESMTP id <S131712AbRA3BLp>;
	Mon, 29 Jan 2001 20:11:45 -0500
Date: Mon, 29 Jan 2001 17:09:34 -0800 (PST)
From: Mike Pontillo <mike_p@polaris.wox.org>
To: "Bryan O'Sullivan" <bos@serpentine.com>
cc: "Michael H. Warfield" <mhw@wittsend.com>,
        John Jasen <jjasen@datafoundation.com>, linux-kernel@vger.kernel.org
Subject: Re: Support for 802.11 cards?
In-Reply-To: <87wvbekyr7.fsf@pelerin.serpentine.com>
Message-ID: <Pine.LNX.4.21.0101291707220.15918-100000@polaris.wox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hmm, this is interesting... I know that the kernel can be set to
try to detect PCI devices on its own, without the help of the BIOS. Is
there any reason why that feature wouldn't work with this particular type
of card?

Thanks,
Mike Pontillo


On 29 Jan 2001, Bryan O'Sullivan wrote:

> m> The ISA bridge also works on the 2.4 kernels but I have not
> m> retested the PCI bridge on 2.4.
> 
> The Lucent PCI-to-Cardbus bridge only works on machines that have a
> recent PCI BIOS.  Any motherboard more than about 16 months old simply
> won't find the bridge card, and hence neither will Linux.
> 
> 	<b
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
