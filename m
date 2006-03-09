Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWCIQzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWCIQzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWCIQzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:55:42 -0500
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:44210 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1751781AbWCIQzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:55:41 -0500
Message-ID: <44105E3B.7030504@concannon.net>
Date: Thu, 09 Mar 2006 11:56:27 -0500
From: Michael Concannon <mike@concannon.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Luke-Jr <luke@dashjr.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com> <200603081311.42080.jk-lkml@sci.fi> <200603091517.31121.luke@dashjr.org>
In-Reply-To: <200603091517.31121.luke@dashjr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> On Wednesday 08 March 2006 11:11, Jan Knutar wrote:
>   
>> :( The softmodem cost only 50E. A "real" modem is about 150E -250E or
>>     
Is "E" Euros?  Is so, really? 56K modems look to be about $10-20(USD) 
around here (US NE)

> Fund a project to implement a software modem. While a "real" modem might have 
> better performance, softmodems are more of a raw interface which can be 
> better in the long run-- for example, if some new super modulation is 
> produced for 1mbit over regular phone lines, you could possibly just upgrade 
> your modem software for the new feature. You can also use the modem for voice 
> capabilities, and have your computer act as an answering machine while you're 
> not using it for the internet.
>   
This is a disease... "future proofing" is a lie to get you to buy 
hardware/software that you don't need... by the time you are ready to 
use your cell phone as an ground penetrating radar treasure hunting 
device, you will likely be ready to toss the old one anyway because the 
battery only lasts 5minutes and the power cord on the charger that costs 
3X the phone is frayed.

I am not saying that there are not things which are really are 
upgradeable (word processors, image manipulators, media players, 
compilers etc...), I am saying that in the long run when you consider 
unit cost, man power, electricity consumption, heat dissipation, there 
are a number of tasks being offloaded into software that are far less 
"efficient" and cost effective on a net basis.

Using your PC as an POTS answering machine is a waste of electricity... 
(of course that assumes that you are not running a  multi-gigatexel-per 
second OpenGL screen saver when you are not around in which case all is 
lost, go ahead)... If you must, why waste GHz cycles to do what a KHz 
embedded DSP can do for $10 (retail)?

We have a long way to go before PCs are anywhere close to as efficient 
as they can be about power consumption, but it won't help if we all buy 
TVs and toasters with quad core 64bit processors because we might want 
to start our own personal SETI project ... someday...

When you consider the cost of a device, consider the whole cost of it:
a. the time required to install maintain with each new Fedora/Ubuntu 
release every 8 minutes...
b. the cost of not being able to use it because the softmodem only works 
on this or that rev of OS/Motherboard, etc...
c. the cost of "exploits" in your softmodem stack allowing dial up 
hacking...
d. silly regulations which force binary blobs to keep me from roasting 
my neighbor with 802.11 cranked up to ... well "11"...
e. the cost of the power consumed doing DSP in a CPU rather than a 
dedicated circuit

There are applications where it will be hard to tell and applications 
where fast paced change in technology means upgrading every few months 
is a reality.  In those cases software content makes sense...

Then there modems which have changed VERY little 10+ years... 

Sorry for the rant - in my business I am watching company after company 
die trying to finish the bloated and impossibly complex software for 
hardware that has been sitting in the lab for a year... perhaps if the 
line between hardware and software were drawn a little more 
realistically,  that would not happen...   It is frustrating to watch...

Software is not free, no matter how little it costs to obtain it, it 
costs a LOT... The "disease" is "just do it in software", the cure is 
actually designing a solution and figuring out where software makes 
sense... Every part of my PC that has drastically increased its software 
content has meant more binary drivers followed by lots of hacking and 
then finally open source support - right around the time I am about to 
replace it with the next shiny new thing...

I am continually dumbfounded that the "driver" layer of PCs is as 
complex as it is... I know why which is that hardware companies cannot 
be troubled to actually finish designing things before they sell them, 
so the driver layer gives them a nice gasket layer to fix all the bugs...

I'll stop ranting now...

/mike

> (Note this is all theoretically possible, and might require actual coding to 
> achieve; just pointing out that softmodem isn't necessarilly worse than 
> hardmodems)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

