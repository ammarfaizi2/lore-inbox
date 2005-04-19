Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVDSTVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVDSTVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVDSTVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:21:18 -0400
Received: from alog0487.analogic.com ([208.224.223.24]:33177 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261252AbVDSTUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:20:50 -0400
Date: Tue, 19 Apr 2005 15:19:34 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL violation by CorAccess?
In-Reply-To: <20050419182529.GT17865@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
References: <20050419175743.GA8339@beton.cybernet.src>
 <20050419182529.GT17865@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Violation? They proudly reply in their article in
 	http://www.linuxdevices.com
that they use Linux, that they embedded a version
of Red Hat, etc.

It's likely that they didn't modify anything in the kernel and
just used some stripped-down C-libraries to make everything fit.

On Tue, 19 Apr 2005, Lennart Sorensen wrote:

> On Tue, Apr 19, 2005 at 05:57:43PM +0000, Karel Kulhavy wrote:
>> I have seen a device by CorAccess which apparently uses Linux and didn't find
>> anything that would suggest it complies to GPL, though I had access to the
>> complete shipping package. Does anyone know about known cause of violation by
>> this company or should I investigate further?
>
> Well what is the case if you use unmodified GPL code, do you still have
> to provide sources to the end user if you give them binaries?  I would
> guess yes, but IANAL.
>
> As far as I can tell their system is a geode GX1 so runs standard x86
> software.  Maybe they didn't have to modify any of the linux kernel to
> run what they needed.  Their applications are their business of course.
> It looks like they use QT as the gui toolkit, which I don't off hand
> know the current license conditions of.  Then there is the web browser
> and such, which has it's own license conditions.  Of course for all I
> know their user manual has an offer of sending a CD with the sources if
> you ask.  Does anyone actually have their product that could check for
> that?
>
> Len Sorensen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
