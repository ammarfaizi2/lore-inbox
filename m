Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbUBWSMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUBWSMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:12:17 -0500
Received: from fmr05.intel.com ([134.134.136.6]:61930 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261977AbUBWSMI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:12:08 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel vs AMD x86-64
Date: Mon, 23 Feb 2004 10:10:16 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA2461@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel vs AMD x86-64
Thread-Index: AcP6NBiqdbybSgHjSKWjLCL/Rs3apwAAp+wg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Adrian Bunk" <bunk@fs.tum.de>
Cc: "Herbert Poetzl" <herbert@13thfloor.at>,
       "Mikael Pettersson" <mikpe@csd.uu.se>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Feb 2004 18:10:17.0914 (UTC) FILETIME=[4AF441A0:01C3FA38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the miscommunication. The page
http://www.intel.com/technology/64bitextensions/faq.htm says at the
_bottom_ at least:

Q9: Is it possible to write software that will run on Intel's processors
with 64-bit extension technology, and AMD's 64-bit capable processors?
A9: With both companies designing entirely different architectures, the
question is whether the operating system and software ported to each
processor will run on the other processor, and the answer is yes in most
cases.

Jun

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Linus Torvalds
>Sent: Monday, February 23, 2004 9:31 AM
>To: Adrian Bunk
>Cc: Herbert Poetzl; Mikael Pettersson; Kernel Mailing List
>Subject: Re: Intel vs AMD x86-64
>
>
>
>On Mon, 23 Feb 2004, Adrian Bunk wrote:
>>
>> In the long term, x86_64 creates more confusion:
>> - SuSE says AMD64 [1]
>> - RedHat says AMD64 [2]
>> - Debian says AMD64 [3]
>>
>> Renaming might be some work today, but it might actually remove
>> confusion in the future.
>
>Well, the thing is, I _like_ a vendor-neutral name.
>
>I think it's important to have multiple sources for a chip, and I think
>one of the problems with IA-64 was that it was a locked-in chip with
>patents and no serious competition internally (ignore the Intel
mouthing
>about "open").
>
>The x86 is so great partly because there's been real competition. So I
>think it's very important to x86-64 to have real competition to make
sure
>nobody gets too dishonest.
>
>So AMD64 is a bad name, partly for the same reason IA32 is a horrible
name
>(and who have you ever heard use the IA32 name except for people who
are
>paid to do so by Intel?)
>
>What I found so irritating is that _hours_ after the Intel
announcement,
>people were _still_ confused about whether the new intel chip was
actually
>compatible with AMD's chips. Why the f*ck not just come out and say so,
>and talk about it? It took people actually reading the manuals (which
>didn't mention it either) to convince some people on the architecture
>newsgroups that yes, "ia32e" was really the same as "amd64" except in
the
>small details that have always set Intel and AMD apart.
>
>So I don't really want to change the name. "x86-64" is a good name. I
just
>wish there was more honesty involved, and less friggin *POSTURING*.
>
>			Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
