Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbRBXVBp>; Sat, 24 Feb 2001 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129611AbRBXVBe>; Sat, 24 Feb 2001 16:01:34 -0500
Received: from et-gw.etinc.com ([207.252.1.2]:57349 "EHLO et-gw.etinc.com")
	by vger.kernel.org with ESMTP id <S129602AbRBXVBT>;
	Sat, 24 Feb 2001 16:01:19 -0500
Message-Id: <5.0.0.25.0.20010224142119.02f50a40@mail.etinc.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Sat, 24 Feb 2001 16:11:45 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Dennis <dennis@etinc.com>
Subject: Re: Linux stifles innovation...
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jesse@cats-chateau.net,
        A.J.Scott@casdn.neu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <E14UEGE-00074Z-00@the-village.bc.nu>
In-Reply-To: <5.0.0.25.0.20010217134720.03630cf0@mail.etinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:47 PM 02/17/2001, Alan Cox wrote:
> > both lock up under load. You dont run a busy ISP i guess. The fact that
> > they come out with a new release every few minutes is clear evidence that
> > it is problematic.
>
>I've been technical director of an ISP. I help manage sites that have not
>insignificant loads and no eepro100 driver problems. For that matter there
>are porn sites using eepro100 drivers.
>
> > Intel doesnt sell the e100.o driver, so they couldnt give a rats ass if it
>
>Your information is wrong. But then it usually is. If you are large 
>corporation
>and would care to talk to Intel they will be happy to discuss it further.

I can lock both of them up in 10 seconds with a simple test.

Why would anyone want to "discuss" paying intel when the license allows you 
to distribute it for nothing? Its clearly designed as an alternative to GPL 
for commercial vendors.

There have been ongoing complaints and discussions over eepro100 problems 
on many of the lists that I know you monitor, so why are you in denial 
about it?


>Of course the single biggest problem with the eepro100 is closedness, and 
>people
>in Intel with attitudes like yours who refuse to release full documentation.


LINUX has no formal documentation, so are you guilty of "closedness" also? 
(ie "where is the 2.4 device driver spec?"), You have source to the e100 
driver (which handles initialization properly,  unlike the eepro driver), 
so what more documentation do you need? it seems that intel is being as 
"open" as the LInux camp, actually more so. At least with the eepro you can 
get the docs under non-disclosure. Under LInux you have no chance unless 
someone feels like helping you.

DB



