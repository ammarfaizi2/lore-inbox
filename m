Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVGUTjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVGUTjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 15:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVGUTjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 15:39:22 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:45842 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S261792AbVGUTjV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 15:39:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <9a874849050721114227f3c6a7@mail.gmail.com>
References: <20050714011208.22598.qmail@science.horizon.com> <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com> <Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr> <20050720174521.73c06bce.pj@sgi.com> <3FC51285-941F-48B6-B5A9-1BBE95CCD816@mac.com> <9a874849050721114227f3c6a7@mail.gmail.com>
X-OriginalArrivalTime: 21 Jul 2005 19:39:14.0065 (UTC) FILETIME=[DFDFC810:01C58E2B]
Content-class: urn:content-classes:message
Subject: Re: kernel guide to space
Date: Thu, 21 Jul 2005 15:37:44 -0400
Message-ID: <Pine.LNX.4.61.0507211528250.12675@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel guide to space
thread-index: AcWOK9/rjwGdbCmyQbiUnxQ0D6fshQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, "Paul Jackson" <pj@sgi.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>, <linux@horizon.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Jul 2005, Jesper Juhl wrote:

> On 7/21/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> On Jul 20, 2005, at 20:45:21, Paul Jackson wrote:
> [...snip...]
>> *cough* TargetStatistics[TargetID].HostAdapterResetsCompleted *cough*
>>
>> I suspect linus would be willing to accept a few cleanup patches for the
>> BusLogic.c file.  Perhaps even one that renames BusLogic.c to buslogic.c
>> like all the other files in the source tree, instead of using nasty
>> StudlyCaps all over :-D
>>
>
> To avoid people doing duplicate work, I just want to say that I've
> started doing a CodingStyle/whitespace/VariableAndFunctionNaming
> cleanup of the BusLogic driver, I'll send the patches to LKML in a few
> hours.
>
Are you going to get rid of the BusLogic* in front of every variable
and function name? (yes please??)  If so, you will need a few days!

It will take probably an hour to parse:
struct BusLogic_FetchHostAdapterLocalRAMReguest FetchHostAdapterLocalRAMRequest
 		^!)

> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
