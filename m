Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbRG3XaK>; Mon, 30 Jul 2001 19:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269083AbRG3XaA>; Mon, 30 Jul 2001 19:30:00 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:27141 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S269081AbRG3X37>; Mon, 30 Jul 2001 19:29:59 -0400
Date: Mon, 30 Jul 2001 17:30:04 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        Thomas Zehetbauer <thomasz@hostmaster.org>,
        linux-kernel@vger.kernel.org
Subject: Re: tulip driver still broken
Message-ID: <20010730173004.A20131@mail.harddata.com>
In-Reply-To: <01073016571903.25803@widmers.oce.srci.oce.int> <Pine.LNX.3.96.1010730180814.27870D-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010730180814.27870D-100000@mandrakesoft.mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jul 30, 2001 at 06:09:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 06:09:33PM -0500, Jeff Garzik wrote:
> On Mon, 30 Jul 2001, Joshua Schmidlkofer wrote:
> > I am afraid of post these days.  However, I must comment that I too am having 
> > trouble with the tulip driver, on several SMC nic's that use the DEC  
> > chipset.  I tried mii_tool, with no success.
> > 
> > I have just been copying the tulip driver from 2.4.4 forward...   because I 
> > don't have enough time to try and create an intelligent error report.
> 
> Thanks for the report!
> 
> Currently there are problems with 21041 old chipsets, which include SMC
> and several other cards.

Hm, I reported few times problems with DS21143 Tulip rev 65, which is
not exactly old, and with anything above tulip-0.9.14, and did not get
back even a half line acknowledment not mentioning annoucements of fixes.
I also posted mii-diag output from a card in working and not working
state.

I have to admit, though, that I did not test that really recently.
RSN...

  Michal
