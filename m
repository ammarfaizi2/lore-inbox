Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWCISew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWCISew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 13:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWCISew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 13:34:52 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:21262 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751248AbWCISew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 13:34:52 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: DervishD <lkml@dervishd.net>
Subject: Re: [future of drivers?] a proposal for binary drivers.
Date: Thu, 9 Mar 2006 18:34:43 +0000
User-Agent: KMail/1.9.1
Cc: Rudolf Randal <rudolf.randal@gmail.com>, linux-kernel@vger.kernel.org
References: <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com> <a03c9a270603090242o713fbe36s895da175bc53140f@mail.gmail.com> <20060309112241.GC14004@DervishD>
In-Reply-To: <20060309112241.GC14004@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603091834.43636.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 March 2006 11:22, DervishD wrote:
>     Hi Rudolf :)
>
>  * Rudolf Randal <rudolf.randal@gmail.com> dixit:
> > I was wondering how many direct letters from lkml people have been
> > written to vendors asking for cooperation with regard to specs,
> > joint development or other solutions for open source drivers for
> > their devices.
>
>     Not exactly kernel related, but anyway: I wrote almost a month
> ago to Menarini Diagnostics. They make glucometers, and the latest
> model they sell can be connected to the PC with a special cable. Of
> course, Windows.
>
>     Since no Linux support is provided for this useful device, I did
> an offer to Menarini: if they provided me with the cable and the
> specs, I'll write a Linux driver and/or a Linux application to
> support *their* product at no cost. I would do it for free because
> I'm very interested in connecting my glucometer to my Linux box.
>
>     I made clear that the driver and/or app would be GPL'd, but on
> the other hand I made clear too that I won't release the specs they
> would give me if they didn't want to (except of course those bits
> exposed by the source code itself).
>
>     I haven't got any answer from them. I can use other glucometer,
> of course, but this one is, IMHO, the best one in the market and I
> don't think any other vendor would give me specs for their products.

Sounds like reverse engineering territory. Fortunately there is software for 
windows that can help you reverse engineer USB or serial-over-USB protocols 
fairly easily. I doubt such a device would be difficult to write a driver 
for.

In my opinion, no answer isn't a good enough answer.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
