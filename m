Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUJGVLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUJGVLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUJGVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:09:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268301AbUJGUsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:48:47 -0400
Date: Thu, 7 Oct 2004 16:48:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
In-Reply-To: <1097175596.31547.111.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410071640250.3287@chaos.analogic.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com> 
 <1097175903.29576.12.camel@localhost.localdomain>
 <1097175596.31547.111.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Alan Cox wrote:

> On Iau, 2004-10-07 at 20:05, Stephen Hemminger wrote:
>> --------------
>> /*
>>  *   Since some in the Linux-kernel development group want to play
>>  *   lawyer, and require that a GPL License exist for every kernel
>>  *   module,  I provide the following:
>>  *
>>  *   Everything in this file (only) is released under the so-called
>>  *   GNU Public License, incorporated herein by reference.
>>  *
>>  *   Now, we just link this with any proprietary code and everybody
>>  *   but the lawyers are happy.
>>  */
>
> What a fascinating object. I hope thats not reflective of OSDL policy 8)
>
> Is fascinating because my first thought was that if they sign the Induce
> act it would be a criminal offence to have it in the USA since its
> clearly an incitement and my second thought was that the Bernstein case
> appears to argue its protected speech. Interesting times 8)
>
> More seriously the goal of MODULE_LICENSE has never been to -enforce-
> GPL licensing. It provides help in understanding what symbols are
> definitely off limits and it allows people to identify proprietary stuff
> loaded into a system to filter bug reports.
>
> The law on derivative works and copyright in general, murkly alas as it
> is, does the enforcing, and unfortunately it is becoming apparent that
> the free software world is going to have to go out soon and crack down
> hard on abusers, especially those simply shipping Linux binaries with no
> source or GPL information.
>
> Alan
>

Naaah. I included it in my module as a joke. Steve didn't take
it as a joke and forwarded it to you. It shows that the whole
MODULE_LICENSE("Whatever") is a joke. Not only that, I can
simply change /proc/sys/kernel/tainted to 0 before submitting
a bug report. This whole GPL thing has taken a real stupid
turn. I guess GNU has really taken over Linux. Stallman will
be real proud of all the work you guys did for him on
GNU/Linux .........

And, yes, we still have free speech in the US, even though
the current administration won't allow us to say anything
bad about it (treason, you know)!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

