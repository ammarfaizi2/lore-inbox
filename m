Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRAYU5Q>; Thu, 25 Jan 2001 15:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRAYU5G>; Thu, 25 Jan 2001 15:57:06 -0500
Received: from mail.myrealbox.com ([192.108.102.201]:61872 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S129305AbRAYU4u>;
	Thu, 25 Jan 2001 15:56:50 -0500
Message-ID: <006601c08711$4bdfb600$9b2f4189@angelw2k>
From: "Micah Gorrell" <angelcode@myrealbox.com>
To: "Tom Sightler" <ttsig@tuxyturvy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: eepro100 problems in 2.4.0
Date: Thu, 25 Jan 2001 13:54:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the problems we where having we are no longer using the machine
with 3 nics.  We are now using a machine with just one and it is going live
next week.  We do need kernel 2.4 because of the process limits in 2.2.
Does the 'Enable Power Management (EXPERIMENTAL)' option fix the no
resources problems?

Micah
___
The irony is that Bill Gates claims to be making a stable operating system
and Linus Torvalds claims to be trying to take over the world
-----Original Message-----
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Micah Gorrell" <angelcode@myrealbox.com>;
<linux-kernel@vger.kernel.org>
Date: Thursday, January 25, 2001 1:48 PM
Subject: Re: eepro100 problems in 2.4.0


> > I have doing some testing with kernel 2.4 and I have had constant
>problems
>> with the eepro100 driver.  Under 2.2 it works perfectly but under 2.4 I
am
>> unable to use more than one card in a server and when I do use one card I
>> get errors stating that eth0 reports no recources.  Has anyone else seen
>> this kind of problem?
>
>I had a similar problem with a server that had dual embedded eepro100
>adapters however selecting the 'Enable Power Management (EXPERIMENTAL)'
>option for the eepro100 seemed to make the problem go away.  I don't really
>know why but it might be worth trying if it wasn't already selected.
>
>Later,
>Tom
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
