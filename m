Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTK2PC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 10:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTK2PC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 10:02:58 -0500
Received: from law12-f67.law12.hotmail.com ([64.4.19.67]:39941 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263767AbTK2PCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 10:02:55 -0500
X-Originating-IP: [24.61.138.213]
X-Originating-Email: [iainbarker@hotmail.com]
From: "Iain Barker" <iainbarker@hotmail.com>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: possible GPL violation by Sigma Designs EM8500 customers
Date: Sat, 29 Nov 2003 10:02:54 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law12-F67OXc3EO2gda0002067e@hotmail.com>
X-OriginalArrivalTime: 29 Nov 2003 15:02:55.0129 (UTC) FILETIME=[DE34E890:01C3B689]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>Just to make things clear, you should change the title of your emails
>here to "possible GPL violation by Liteon". AFAIK, Sigma isn't involved
>in the violation, they almost certainly provided a source code kernel
>for their chipset to Liteon.
>
>Ben.

Thanks Ben,

I've modified the title of this thread to indicate it is the chipset 
customers who are directly at fault. However it seems that every 
manufacturer using the Sigma SDK is making the same error.

The violation seems to be common amongst a large number (all?) Sigma Designs 
customers using their EM8500 chipset SDK. Liteon was the manufacturer for 
the product I have, but in the original thread on LKML it refers also to 
others.

Manufacturers offering binary distributions based on Linux as 'firmware' via 
their support websites are the easiers to check up on. Those with no source 
code included for EM8500 SDK derived products include:

Liteon  http://www.liteonit.com
LVD-1001/2001/2002 DVD player

Vinc    http://www.vinc.com
Bravo-D1 DVD Player

Kiss    http://www.kiss-technology.com
DP-450, DP-500  DVD player

Neodigits http://www.neodigits.com
NeuNeo DVD player

Dream-X   http://www.dreamsat-electronics.com
108   DVD player

Elta  http://www.elta.de
8882  DVD player

RiMax http://www.rimax.net
MPEG4 DVD player


The above is not a comprehensive list, just the ones currently distributing 
binary-only GPL products on their support websites with no mention of Linux 
or the GPL.

Other manufacturers with products using the EM8500 SDK may well do the same 
within their product, including:

Woxter
Momitsu
Brainwave
Cosmic Digital
Jamo
Link Concept
Mustek
Neuston
Shenzhen Skywood
Xoro


As you can see, the violation is widespread. I don't have the time to follow 
up on all of these, and in any case I am really only interested in being 
able to recompile kernel for the Liteon product which I own.

But it does seem like a bigger problem as the Linux GPL license is being 
broadly ignored by embedded manufacturers.

regards,
  Iain

_________________________________________________________________
Need a shot of Hank Williams or Patsy Cline?  The classic country stars are 
always singing on MSN Radio Plus.  Try one month free!  
http://join.msn.com/?page=offers/premiumradio

