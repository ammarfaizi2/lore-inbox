Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVHAM41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVHAM41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 08:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVHAM41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 08:56:27 -0400
Received: from spirit.analogic.com ([208.224.221.4]:27152 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S261877AbVHAM4V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 08:56:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <42EE1324.10304@grupopie.com>
References: <1122861215.11148.26.camel@localhost.localdomain>  <1122872189.5299.1.camel@localhost.localdomain> <1122873057.15825.26.camel@mindpipe> <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr> <42EE1324.10304@grupopie.com>
X-OriginalArrivalTime: 01 Aug 2005 12:56:16.0238 (UTC) FILETIME=[674F68E0:01C59698]
Content-class: urn:content-classes:message
Subject: Re: IBM HDAPS, I need a tip.
Date: Mon, 1 Aug 2005 08:55:53 -0400
Message-ID: <Pine.LNX.4.61.0508010836020.30161@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IBM HDAPS, I need a tip.
thread-index: AcWWmGdZ7hfhm/eSRKaLWTqHLojrJg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Lee Revell" <rlrevell@joe-job.com>, <abonilla@linuxwireless.org>,
       <linux-kernel@vger.kernel.org>,
       "hdaps devel" <hdaps-devel@lists.sourceforge.net>,
       "Yani Ioannou" <yani.ioannou@gmail.com>, "Dave Hansen" <dave@sr71.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Aug 2005, Paulo Marques wrote:

> Jan Engelhardt wrote:
>>> So in order to calibrate it you need a readily available source of
>>> constant acceleration, preferably with a known value.
>>>
>>> Hint: -9.8 m/sec^2.
>>
>> Drop it out of the window? :)
>
> No, no. Constant gravity (like having the laptop sitting on the desk)
> "feels like" constant acceleration.
>
> Dropping it out of the window should measure 0 m/sec^2, because the
> accelerometer is not working on an inertial referential (I hope this is
> the correct term in english...). For the accelerometer, this is just
> like the feeling of free falling inside an elevator: no gravity :)
>
> --
> Paulo Marques - www.grupopie.com

You need a centrifuge or something that works like one. You can
make one and you can calibrate it using simple techniques. For
instance, you can swing the mass (laptop) over your head, round
and round with your arm. If the rate is such that the mass "just"
falls over the top, the 'G's at that point are zero. At the
bottom of the swing, the 'G's will be maximum. If you used a
fish-scale (spring-scale) to swing the whole thing, you could
measure its static weight, then observe the apparent weight
everywhere along the swing arc. If you don't have to go through
0 Gs, you can just swing the whole thing around horizontally
and observe the fish-scale. The 'G' load is exactly the indicated
weight / static weight.

As a relative measure, a 5.5 lb weight, swung through a 5ft
diameter, (2.5 ft radius) arc at such a speed that it "just"
falls through the top, exerts about 4 Gs (22 lb) at the bottom.
Don't accidentally hit something. Impact Gs may make your
experiment expensive.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
