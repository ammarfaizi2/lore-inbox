Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313126AbSC1Jzs>; Thu, 28 Mar 2002 04:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSC1Jzi>; Thu, 28 Mar 2002 04:55:38 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44811 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313126AbSC1JzX>; Thu, 28 Mar 2002 04:55:23 -0500
Message-ID: <3CA2E821.9030008@evision-ventures.com>
Date: Thu, 28 Mar 2002 10:53:37 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jos Hulzink <josh@stack.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, andersen@codepoet.org,
        Andre Hedrick <andre@linux-ide.org>, jw schultz <jw@pegasys.ws>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Offtopic: Re: DE and hot-swap disk caddies
In-Reply-To: <20020328103854.O5099-100000@toad.stack.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink wrote:
> On Thu, 28 Mar 2002, Alan Cox wrote:
> 
> 
>>>Then there is this talking around about the "tristate of some" device.
>>>I'm really a bit sick of it. Becouse there is no such a state
>>>like a tri-state. We have just bus drivers on both ends.
>>>They are implemented usually as Schmidt triggers. They have three
>>>possible states on output: low voltage, high voltage, high resistance.
>>
>>Which is one, two, three states -> tri-state.
> 
> 
> Eeks, a Linux developper who can count ;-)
> 
> 
>>Electronics terminology then abuses that to mean the high impedance state (not
>>high resistance please if we are going to be picky).
> 
> 
> Correct, though I hope in most cases the impedance is almost equal to the
> resistance, otherwise there would be problems at the current high speeds.
> 
> For those who don't know the difference:
> 
> Resistance is only a part of impedance. Inpedance also contains a
> frequency-dependant part, caused by induction in, and capacity between
> wires and electronic devices.
> 
> The idea in formula:
> 
> Induction = 	Resistance +
> 		frequency * Induction +
> 		1 / (frequency * Capacity)
> 
> For an accurate formula, see any book about EE.

Ehmmm... it was a just too direct translation of the german term hochohmig ;-).
And indeed the correct english term is high-impedance.

