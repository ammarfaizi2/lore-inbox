Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268709AbRG3XA1>; Mon, 30 Jul 2001 19:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268744AbRG3XAR>; Mon, 30 Jul 2001 19:00:17 -0400
Received: from [208.187.172.194] ([208.187.172.194]:35613 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S268709AbRG3XAK>; Mon, 30 Jul 2001 19:00:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joshua Schmidlkofer <menion@srci.iwpsd.org>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Subject: Re: tulip driver still broken
Date: Mon, 30 Jul 2001 16:57:19 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010731001907.A21982@hostmaster.org>
In-Reply-To: <20010731001907.A21982@hostmaster.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01073016571903.25803@widmers.oce.srci.oce.int>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I am afraid of post these days.  However, I must comment that I too am having 
trouble with the tulip driver, on several SMC nic's that use the DEC  
chipset.  I tried mii_tool, with no success.

I have just been copying the tulip driver from 2.4.4 forward...   because I 
don't have enough time to try and create an intelligent error report.

thanks,
 
 joshua

On Monday 30 July 2001 04:19 pm, Thomas Zehetbauer wrote:
> My genuine digital network interface card ceased to work with the tulip
> driver contained in kernel revisions >= 2.4.4 and the development driver
> from sourceforge.net.
>
> It seems that the driver incorrectly configures the card for full duplex
> mode and I could not figure out how to override this with the new
> MODULE_PARM macro.
>
> I am now using the stable driver 0.9.14 from sourceforge.net which works
> fine.
>
> Further information available by request!
>
> Tom
>
> Quantum Mechanics is God's version of "Trust me."

