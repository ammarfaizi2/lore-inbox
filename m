Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284507AbRLDAVE>; Mon, 3 Dec 2001 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284620AbRLDAPY>; Mon, 3 Dec 2001 19:15:24 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:6061 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S284507AbRLCMb6>;
	Mon, 3 Dec 2001 07:31:58 -0500
Message-ID: <3C0C1ACB.75F57C22@sltnet.lk>
Date: Mon, 03 Dec 2001 18:37:31 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.14-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: linux-kernel@vger.kernel.org
Subject: Re: "spurious 8259A interrupt: IRQ7": Thanks
In-Reply-To: <Pine.LNX.4.33.0111300926050.4564-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> Ishan wrote...
> >I don't have any 8259A's on my motherboard and this led me to kgcc.
> 
> The 8259A is actually Intel's Programmable Interrupt Controller. Which
> guessing from your PC specs you probably have.
> 
> Zwane Mwaikambo

Thanks.
	I _had_ come across the 8259A before, but I'm ashamed to say that
I haven't looked for it on my board, nor have I seen it in anywhare in
/proc.
Hence the bad judgement :) Your mail just clicked everything to place.
	At any rate, I haven't got this message from the kernel after 2.4.8
_with_ stable compilers. My IRQ7 is used by the printer driver which is
compiled-in.

	-ioj
