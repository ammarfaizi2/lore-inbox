Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSLBTCQ>; Mon, 2 Dec 2002 14:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSLBTCP>; Mon, 2 Dec 2002 14:02:15 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:63652 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264886AbSLBTCN>; Mon, 2 Dec 2002 14:02:13 -0500
Message-ID: <3DEBAAE6.6000106@enib.fr>
Date: Mon, 02 Dec 2002 19:48:06 +0100
From: XI <xizard@enib.fr>
Reply-To: xizard@enib.fr
Organization: http://www.chez.com/xizard
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
References: <3DEA322B.40204@enib.fr>	<1038765233.30392.0.camel@irongate.swansea.linux.org.uk> 	<3DEAA660.60004@enib.fr> <1038845393.1020.26.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-12-02 at 00:16, XI wrote:
> 
>>I was thinking about a problem with my chipset (AMD760MPX, motherboard 
>>tyan tiger MPX); because I have done some tests on a PC with a matrox 
>>G200 PCI and a sound blaster live, with a chipset via KT333 and the 
>>problem doesn't seems to occur. Is it possible?
> 
> 
> Could be - the newer kernel supports IDE DMA, and in my experience the
> AMD76x has serious fairness problems (I gave up using it for video
> capture)
> 

This doesn't reassure me :-) but I didn't get the choice for an SMP 
machine with some athlon processors.

Note that I am also able to use IDE DMA with the kernel 2.4.8 (ie hdparm 
-d 1 /dev/hd. works)


So now, do you want me to try other kernel version in order to find in 
what version the problem appeared?

Xavier

