Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265067AbUD3EdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbUD3EdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 00:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUD3EdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 00:33:15 -0400
Received: from alt.aurema.com ([203.217.18.57]:2990 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S265067AbUD3EdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 00:33:13 -0400
Message-ID: <4091D6D4.8070507@aurema.com>
Date: Fri, 30 Apr 2004 14:32:20 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Marc Boucher <marc@linuxant.com>, Sean Estabrooks <seanlkml@rogers.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Wagland <paul@wagland.net>,
       Rik van Riel <riel@redhat.com>, Timothy Miller <miller@techsource.com>,
       koke@sindominio.net, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>	<20040429195553.4fba0da7.seanlkml@rogers.com>	<3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com> <200404300618.37718.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200404300618.37718.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Friday 30 of April 2004 04:15, Marc Boucher wrote:
> 
>>Dear Sean,
>>
>>On Apr 29, 2004, at 7:55 PM, Sean Estabrooks wrote:
>>
>>>Perhaps others on this list are getting as tired as I am of your using
>>>the term "religious bias" as a negative connotation against people who
>>>support and protect the open source nature of Linux.   Maybe you could
>>>at least pretend to respect the people who you supposedly apologized
>>>to.
>>
>>I not only highly respect Rusty but have closely worked and been
>>friends with him for several years. The same applies to several other
>>kernel developers.
>>
>>Please don't get me wrong. We are entirely for the open-source nature
>>of Linux, and I have been personally contributing for the last 15 years
>>to many open-source projects (for examples, see the AUTHORS section of
>>"man iptables", or search google for my previous email addresses
>>marc@mbsi.ca & marc@cam.org to get more historical background).
> 
> 
> Well, people change over time.  8)
> 
> from http://www.linuxant.com/driverloader/
> 
> "DriverLoader technology is the ideal Linux solution to support devices for
>  which no adequate native open-source drivers are available. It also allows
>  vendors to drastically reduce time to market or eliminate the need to support
>  multiple drivers for Windows and Linux. By using the same driver on both
>  platforms, significant resources can be saved."
> 
> Rusty was right.

Why did you omit the next paragraph (which completes the story):

"We have attempted to reduce the inconvenience of binary-only drivers by 
separating the proprietary code from the operating-system specific code. 
The latter is provided in source form, allowing users to install the 
drivers under any supported version (2.4 or later) of the Linux kernel."

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

