Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265268AbRGBOSj>; Mon, 2 Jul 2001 10:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265300AbRGBOSa>; Mon, 2 Jul 2001 10:18:30 -0400
Received: from datafoundation.com ([209.150.125.194]:56580 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S265268AbRGBOSV>; Mon, 2 Jul 2001 10:18:21 -0400
Date: Mon, 2 Jul 2001 10:18:14 -0400 (EDT)
From: John Jasen <jjasen@datafoundation.com>
To: Juergen Wolf <JuWo@N-Club.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <3B40611D.F1485C1B@N-Club.de>
Message-ID: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2001, Juergen Wolf wrote:

> currently I experience some strange problems with every kernels newer
> than 2.4.2 and my SMC Etherpower II network card. While running such a
> kernel, the network hangs and I get lots of errors like these listed
> below:

under the dumb question department:

a) bad cable?
b) not negotiating speed and duplex with the switch correctly?
c) bad card?
d) IRQ sharing causing a conflict?

I'm less predisposed to blame the card in general or the driver, as I have
probably about a dozen SMC epic100 cards here, in single processor x86,
dual x86, and dual alphas that have been flawless from about 2.2.14 to
2.4.4.


