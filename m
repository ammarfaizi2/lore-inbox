Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVHBRq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVHBRq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVHBRq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:46:29 -0400
Received: from spirit.analogic.com ([208.224.221.4]:39182 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S261587AbVHBRq2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:46:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050802170637.GO10080@vanheusden.com>
References: <42ED4CCF.6020803@andrew.cmu.edu><20050731224752.GC27580@elf.ucw.cz><1122852234.13000.27.camel@mindpipe><20050801074447.GJ9841@khan.acc.umu.se><42EE4B4A.80602@andrew.cmu.edu> <20050801204245.GC17258@thunk.org><42EEFB9B.10508@andrew.cmu.edu> <42EF70BD.7070804@earthlink.net><1122991380.5490.24.camel@mindpipe> <20050802141240.GG2408@suse.de> <20050802170637.GO10080@vanheusden.com>
X-OriginalArrivalTime: 02 Aug 2005 17:46:04.0937 (UTC) FILETIME=[0E320F90:01C5978A]
Content-class: urn:content-classes:message
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Date: Tue, 2 Aug 2005 13:45:30 -0400
Message-ID: <Pine.LNX.4.61.0508021323450.5695@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Power consumption HZ100, HZ250, HZ1000: new numbers
thread-index: AcWXig47Ep64hcG9RNalOqJn+tGmJw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Folkert van Heusden" <folkert@vanheusden.com>
Cc: "Jens Axboe" <axboe@suse.de>, "Lee Revell" <rlrevell@joe-job.com>,
       <sclark46@earthlink.net>, "James Bruce" <bruce@andrew.cmu.edu>,
       "Theodore Ts'o" <tytso@mit.edu>, "David Weinehall" <tao@acc.umu.se>,
       "Pavel Machek" <pavel@ucw.cz>, "Marc Ballarin" <Ballarin.Marc@gmx.de>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Aug 2005, Folkert van Heusden wrote:

>>>> Maybe new desktop systems - but what about the tens of millions of old
>>>> systems that don't.
>>>
>>> Does anyone really give a shit about saving power on the desktop anyway?
>>> This is basically a laptop issue.
>>
>> Eh yes, very much.
>
> Indeed. Safe the environment etc.
>
>
> Folkert van Heusden

Computers are nearly 100% efficient as heaters. A computer that
consumes 100 watts of power puts out a few milliwatts over a
network connection. The rest is heat. For every watt of heat,
it takes about 1/8th watt to carry the heat away with modern
air-conditioners.

So, just my 100 watt "heater" will cost me about US$18.00 per
month if I leave it on continuously. I read somewhere, I
think in "Communications", that at any one time there are
40 million personal computers "connected" to the Internet.
That's 40,000,000 * 18.00 = US$720,000,000.00 per month
being consumed, plus the 720,000,000 / 8 = US$90,000,000 to
keep them cool.

It's a MONEY problem, something everybody can understand.
It's not an environmental problem at all. The environment
can certainly sink the 40,000,000 * 100 = 4,000,000,000
(4 billion) watts of power. That's about the sun's energy
falling on a 10 km^2 area of land near the equator, a
drop in the bucket.

Ideally, a computer that's not doing any work should not
consume any power. However, even if you use static RAM
and a low-power CPU, computers have always been power
sinks. Recent GHz "advances" have upped the power loss
to unprecedented amounts. Anything that can help ameliorate
the problem will certainly be appreciated by "the masses".


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
