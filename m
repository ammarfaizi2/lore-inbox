Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144543AbRA2AVk>; Sun, 28 Jan 2001 19:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144574AbRA2AVb>; Sun, 28 Jan 2001 19:21:31 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:7941 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S144543AbRA2AVN>; Sun, 28 Jan 2001 19:21:13 -0500
Message-ID: <3A74B59A.5070502@redhat.com>
Date: Sun, 28 Jan 2001 18:13:14 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: John Jasen <jjasen@datafoundation.com>,
        Mike Pontillo <mike_p@polaris.wox.org>, linux-kernel@vger.kernel.org
Subject: Re: Support for 802.11 cards?
In-Reply-To: <Pine.LNX.4.21.0101281344040.12805-100000@polaris.wox.org> <Pine.LNX.4.30.0101281704050.2343-100000@flash.datafoundation.com> <20010128182358.F23716@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a rather informative discussion of wireless support at :

http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Linux.Wireless.drivers.html

Though possibly a little out of date, the author of this obviously did 
their research. Kudos!

--
Joe

Michael H. Warfield wrote:

> On Sun, Jan 28, 2001 at 05:07:33PM -0500, John Jasen wrote:
> 
>> On Sun, 28 Jan 2001, Mike Pontillo wrote:
> 
> 
>>> 	I was wondering what 802.11 PCI cards anyone knows of that run
>>> under Linux-2.4. (or 2.2 for that matter)
>> 
> 
>> I _think_ a good many of the 802.11 wireless ISA and PCI cards are just
>> bus to PCMCIA adapters, so it would be a question of whether or not the
>> PCMCIA card is supported and if the bridge is supported.
> 
> 
> 	Last I knew (straight from the Lucent people), the ISA bridge
> card worked fine and the PCI card did NOT work at all.  I've since
> confirmed that, first hand, myself (I currently have the ISA bridge in
> operation) on the 2.2 kernels.  The ISA bridge also works on the 2.4
> kernels but I have not retested the PCI bridge on 2.4.  The Lucent
> people claim that the Linux pcmcia people are aware of the problem.
> 
> 	Mike



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
