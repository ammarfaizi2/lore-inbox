Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWC1Xal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWC1Xal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWC1Xal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:30:41 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:48048 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S964836AbWC1Xak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:30:40 -0500
Message-ID: <4429D322.7040907@wolfmountaingroup.com>
Date: Tue, 28 Mar 2006 17:21:54 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hda-intel woes
References: <20060327231049.GA30641@localhost.in.y0ur.4ss> <4428872E.3020308@wolfmountaingroup.com> <4429C252.2000405@tmr.com>
In-Reply-To: <4429C252.2000405@tmr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Jeff V. Merkey wrote:
>
>>
>> Visit www.redhat.com.
>>
>> Purchase a support contract for customer service, fastest way to get 
>> help.
>
>
> Several things have escaped you:
>  1 - common politeness - the question was reasonable


Common politeness?  The person posted several times and was ignored.  We 
purchase and use red hat products all day long and their service is 
excellent.  When our cutomers call for support problems get fixed and 
addressed -- without our customers being harnessed and used as guinea 
pigs to test buggy patches.  Some people are simply users and need to go 
to the supplier of the distribution to get drivers or help.   Red Hat's 
online forums are outstanding and most of these questions get answered 
and addressed just by searching their site -- even for distros from 
other vendors.  Intel Video and other support in FC2, ES4, etc. must 
come from Red hat and Suse since their kernels are so forked, they 
cannot be used without several hundred patches (NPTL, etc). 

>  2 - sound doesn't work on ASUS laptops up thru at least 2.6.15.3

>  3 - Fedora is user supported

And has an enormous knoweldge base on red hat's website covering 
numerous issues. 

>
> Having spent months trying to convince people that there was no 
> {various_things} to mute or unmute, it didn't work with earphones 
> either, etc, I decided that given a choice between (a) Windows, (b) a 
> new laptop which might not work either, or (c) a cheap USB sound 
> setup, I decided to stop banging my head on that particular rock.
>
> My friend bought one at the same time I did, he reports that neither 
> the latest Fedora kernel, 2.6.15.6, or 2.6.16 works. Downloading the 
> latest ALSA patches may work if they apply to the kernel you have.
>
>
I wasn;t trying to be flippant or rude, I was simply pointing this 
person to a website where they might find answers.  Most users are not 
programmers and expecting them to debug patches and rebuild a kernel 
(which won't work in most cases because of forking and massive patches 
by the DISTRO vendors) .
Linux has grown up.    People using laptops with distros will find a lot 
of answers on these forums. 

How about wireless drivers?  Bcm drivers for example.  Written as NDIS 
and using ndiswrapper.  Laptop issues are complicated and not general 
bugs.  LKML isn;t useful to address these issues.  I don't even get 
responses on AMD issues and I do kernel development all day long.    And 
I don't use stock kernel.org releases any longer since the distro's have 
forked so extensively. 

And the whining about where a website link was posted on a reply is not 
something to get crosswise over.  Next time I'll respond quietly to the 
user and save  the vitriol.

Jeff
