Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWD1RiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWD1RiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWD1RiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:38:17 -0400
Received: from spirit.analogic.com ([204.178.40.4]:50960 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751754AbWD1RiR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:38:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <44524A8A.3060308@argo.co.il>
X-OriginalArrivalTime: 28 Apr 2006 17:38:13.0686 (UTC) FILETIME=[866D9D60:01C66AEA]
Content-class: urn:content-classes:message
Subject: Re: Compiling C++ modules
Date: Fri, 28 Apr 2006 13:38:06 -0400
Message-ID: <Pine.LNX.4.61.0604281309250.7998@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compiling C++ modules
thread-index: AcZq6oZ3mMO+KR3XRu+pp84NtSMckQ==
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua> <20060427201531.GH13027@w.ods.org> <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com> <4451E185.9030107@argo.co.il> <mj+md-20060428.105455.7620.atrey@ucw.cz> <4451FCCC.4010006@argo.co.il> <Pine.LNX.4.61.0604281755360.9011@yvahk01.tjqt.qr> <44524A8A.3060308@argo.co.il>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Avi Kivity" <avi@argo.co.il>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "Martin Mares" <mj@ucw.cz>,
       "Davi Arnaut" <davi.lkml@gmail.com>, "Willy Tarreau" <willy@w.ods.org>,
       "Denis Vlasenko" <vda@ilport.com.ua>, <dtor_core@ameritech.net>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Apr 2006, Avi Kivity wrote:

> Jan Engelhardt wrote:
>>> The high level language allows you to concentrate on the algorithms which is
>>> where the performance comes from.
>>>
>> Do you consider e.g. Perl or Python highlevel?
>>
>
> I once wrote Perl. I deeply regret the experience. But yes, they are
> both high(er) level. There are even higher levels to aspire to.
>
>> If so: I doubt that's where performance can come from. Ever. (Unless you
>> cheat by using XS.)
>>
>
> Given infinite time, patience, and concentration, the C or C++ program
> will always win over Python; as assembly will win over C or C++.
>
> If your time is bounded, your Python code might be running while you're
> still typing in your C code, you're be profiling and making changes to
> the alghorithm in Python while hunting for that mysterious segmentation
> fault in C (thank goodness for valgrind), and adding multithreading to
> the third and final version of your Python code while debating whether
> to buy more memory or sit down and chase that memory leak.
>
> Developer performance equates to runtime performance.
>

Read what you wrote! It's absolutely, incredibly stupid!

The cost in developer time is borne once. The cost of performance
is borne every time you run the application.

> ps. Yes, that wouldn't work for a simple example like counting words in
> a file. Try something more complex, like an SCM system.
>
> --
> Do not meddle in the internals of kernels, for they are subtle and quick to panic.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
