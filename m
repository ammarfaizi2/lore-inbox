Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSIBUsG>; Mon, 2 Sep 2002 16:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318470AbSIBUsG>; Mon, 2 Sep 2002 16:48:06 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:1626
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S318458AbSIBUsG> convert rfc822-to-8bit; Mon, 2 Sep 2002 16:48:06 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Poweroff error from 2.4.20-pre5-ac1 w/ Asus A7M266-D motherboard AND question
Date: Mon, 2 Sep 2002 16:55:19 -0400
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org
References: <200209021618.15767.spstarr@sh0n.net> <1030999886.3582.76.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1030999886.3582.76.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209021655.19139.spstarr@sh0n.net>
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.100.232.94] using ID <shawn.starr@rogers.com> at Mon, 2 Sep 2002 16:52:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll grab that and other things. Do you need another A7M266-D test monkey?

Shawn.

On September 2, 2002 04:51 pm, Alan Cox wrote:

> On Mon, 2002-09-02 at 21:18, Shawn Starr wrote:
> > First the question:
> >
> > Why does Linux detect my AMD chipset as ONLY the MP and not the MPX? I
> > thought the A7M266-D had the MPX?
>
> The northbridge is the same so that shouldnt matter. The hdc is probably
> a bug in the new ide code. It may be fixed by pre3 (coming up soon)

