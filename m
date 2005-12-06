Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVLFOJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVLFOJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVLFOJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:09:18 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:21776 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932585AbVLFOJR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:09:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4394ECA7.80808@didntduck.org>
X-OriginalArrivalTime: 06 Dec 2005 14:09:12.0051 (UTC) FILETIME=[A1F5BC30:01C5FA6E]
Content-class: urn:content-classes:message
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Tue, 6 Dec 2005 09:09:11 -0500
Message-ID: <Pine.LNX.4.61.0512060855050.12611@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux in a binary world... a doomsday scenario
Thread-Index: AcX6bqIBcblxCI18SSyf+dGoHyqg/w==
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>  <20051205121851.GC2838@holomorphy.com>  <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>  <20051206030828.GA823@opteron.random>  <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com> <1133869465.4836.11.camel@laptopd505.fenrus.org> <4394ECA7.80808@didntduck.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Brian Gerst" <bgerst@didntduck.org>
Cc: "Arjan van de Ven" <arjan@infradead.org>, "M." <vo.sinh@gmail.com>,
       "Andrea Arcangeli" <andrea@suse.de>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Dec 2005, Brian Gerst wrote:

> Arjan van de Ven wrote:
>> On Tue, 2005-12-06 at 12:07 +0100, M. wrote:
>>>
>>> On 12/6/05, Andrea Arcangeli <andrea@suse.de> wrote:
>>>         On Mon, Dec 05, 2005 at 09:31:30AM -0500, Brian Gerst wrote:
>>>        > The problem with this statement is that Linux users are a
>>>         drop in the
>>>        > bucket of sales for this hardware.  Boycotting doesn't cost
>>>         the vendors
>>>        > enough to make them care.  And this does nothing for people
>>>         who are
>>>        > converting over to Linux, and didn't buy hardware with that
>>>        > consideration in mind.
>>>
>>>         Effectively this is why 3d drivers are the only thing we
>>>         litearlly lost
>>>         control of. But my email was general. I wasn't only speaking
>>>         of 3d
>>>         hardware.
>>>
>>>         For 3d you're very well right, but once linux becomes
>>>         mainstream in the
>>>         desktop, things could change.
>>>
>>> Without proper hardware support linux is not going to become
>>> mainstream in the desktop area. In fact It's adopted in offices, by
>>> governments and schools for security, reliability and openoffirce.org
>>> (low $$).
>>
>> but... "proper hardware support" can be open source, that's the whole
>> point! Everyone considering binary only support "full" causes the entire
>> problem of not being able to run without binary modules anymore, which
>> in turn means you're either stuck with enterprise distro kernels, or
>> linux is stuck with a kernel that can't be developed on anymore in a 2.7
>> style series.
>>
>> Nobody is arguing that hardware shouldn't be supported, to the contrary.
>> I and others are arguing that short term binary only "support" isn't
>> real support in the long term, and in both the long and short term leads
>> to a significant reduction in choice. Note: NVidia right now is nice
>> enough to do the blob+glue layer thing. Many others don't, they only
>> provide modules for certain enterprise distros. Now those schools and
>> governments of course run those enterprise distros... but what does that
>> gain in the end? Security? It doesn't; several of these binary modules
>> actually introduce security holes (the most famous one is an old 3D
>> driver of a company I won't name that had a "make me root" ioctl).
>> Price? Well those enterprise distribution companies need to make money
>> somehow... so while the price may be lower... you're stuck to them
>> again..
>>
>>> So , without some sort of effort from kernel developers, things
>>> arent going to change.
>>
>> I would turn this around; without some sort of effort from the USERS,
>> things aren't going to change. As long as USERS don't use their purchase
>> power to urge vendors that linux and open source are important, nothing
>> is going to improve. Going binary is not a long term improvement! It's
>> more like a quick shot of heroin that makes you feel better today,
>> rather than going to a psychiatrist who helps you out of your depression
>> for the rest of your life.
>
> Once again I'd like to point out that user's purchase power means jack
> when they only have two choices for video:  ATI and Nvidia.  You can't
> walk into a computer store and find anything else (I don't count
> integrated video on the motherboard as a solution, since only Intel
> boards have it, sorry AMD users).  Even over the web it's hard to find
> anything else.  I'm not trying to defend closed source here, but you
> people just have to face the reality that trying to use the market to
> get our way is just not going to work with video.  The only way forward
> is reverse engineering.  We aren't going to get help from the vendors so
> we have to help ourselves.
>
> --
> 				Brian Gerst

When the linux-BIOS group started, few knew where to start. Then,
mysteriously, there was a complete directory tree of a well-known
BIOS that appeared on the web. That was a start.

Want video drivers? I would suggest starting a Linux-video group.
Start with a few hacks of some reverse-engineered stuff then I
guess some help will mysteriously appear, especially if the
blob/glue stuff is done in that group, too. A video board company
doesn't care about operating systems! They care about selling
boards. The easier it is to relate to their video hardware, the
more likely help will be forthcoming.

Also, you are still likely to have a blob/glue system because
the blob is the stuff that needs to be uploaded to the FPGA upon
startup! Although serial eproms are cheap, few PC/Board vendors
will spend the money to put the blob on the board where it belongs.
So, usually it needs to be bit-banged into the device upon startup.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
