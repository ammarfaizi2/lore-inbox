Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWCIMNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWCIMNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWCIMNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:13:53 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:47530 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932178AbWCIMNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:13:52 -0500
Date: Thu, 9 Mar 2006 13:13:47 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Rudolf Randal <rudolf.randal@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
Message-ID: <20060309121347.GA19302@rhlx01.fht-esslingen.de>
References: <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKIELAKJAB.davids@webmaster.com> <21d7e9970603090202v22205fc6ha5b4cec12f0a0507@mail.gmail.com> <a03c9a270603090242o713fbe36s895da175bc53140f@mail.gmail.com> <20060309112241.GC14004@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309112241.GC14004@DervishD>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 09, 2006 at 12:22:59PM +0100, DervishD wrote:
>     Not exactly kernel related, but anyway: I wrote almost a month
> ago to Menarini Diagnostics. They make glucometers, and the latest
> model they sell can be connected to the PC with a special cable. Of
> course, Windows.

[...]

>     I haven't got any answer from them. I can use other glucometer,
> of course, but this one is, IMHO, the best one in the market and I
> don't think any other vendor would give me specs for their products.
Possibly you wrote one mail only?
Then try again... they might easily be too busy or whatever.

>     And please note that I'm not talking about all the specifications
> of the glucometer: they can keep secret the way the glucometer makes
> the measurements, I don't give a heck about that. I only want the
> *communication* specs, so I'm able to retrieve data from the
> glucometer through the cable (which is USB, AFAIK, so probably it
> won't need a new driver).
Be certain to use libusb if possible instead of a new USB driver
(which you seem to indicate properly above)

>     I don't know how much Menarini paid for the Windows version of
> the software. Probably more than the entire Linux kernel will cost to
> produce in its entire life. The cost of a Linux version for them will
> be a cable and a PDF document of the communication specification,
> which probably will be a known protocol. They don't want to do it
> because: a) they don't understand a word of the open source movement
> and how it can be used to save money; or b) they're so stupid,
> stubborn and money avid that won't do anything that doesn't involve
> money, even if the money goes out of their own pockets!
You're talking strange things here.
"Probably more than the entire Linux kernel will cost to produce in its
entire life" - yah, right!
And you're jumping to conclusions and resorting to name calling
about their (non-)behaviour.

Andreas Mohr
