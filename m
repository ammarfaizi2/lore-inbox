Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUD3QGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUD3QGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265096AbUD3QGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:06:06 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:59663 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265097AbUD3QGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:06:02 -0400
Message-ID: <40927A86.30207@techsource.com>
Date: Fri, 30 Apr 2004 12:10:46 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marc Boucher <marc@linuxant.com>, Sean Estabrooks <seanlkml@rogers.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Wagland <paul@wagland.net>,
       Rik van Riel <riel@redhat.com>, koke@sindominio.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>	<20040429195553.4fba0da7.seanlkml@rogers.com>	<3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com> <200404300618.37718.bzolnier@elka.pw.edu.pl> <4091D6D4.8070507@aurema.com>
In-Reply-To: <4091D6D4.8070507@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Williams wrote:

>> "DriverLoader technology is the ideal Linux solution to support 
>> devices for
>>  which no adequate native open-source drivers are available. It also 
>> allows
>>  vendors to drastically reduce time to market or eliminate the need to 
>> support
>>  multiple drivers for Windows and Linux. By using the same driver on both
>>  platforms, significant resources can be saved."
>>
>> Rusty was right.
> 
> 
> Why did you omit the next paragraph (which completes the story):
> 
> "We have attempted to reduce the inconvenience of binary-only drivers by 
> separating the proprietary code from the operating-system specific code. 
> The latter is provided in source form, allowing users to install the 
> drivers under any supported version (2.4 or later) of the Linux kernel."


While it does allow for Linux to get certain kinds of drivers quicker, 
it turns hardware developers into slackers who don't want to REALLY 
support Linux and eats away at the spirit of Linux as an open system.

What you're doing may short-term enhance hardware support for Linux, but 
in the long term, it is a set-back for Linux because it does not 
encourage hardware vendors to support Linux directly and even pushes 
true Linux support further into the future.

