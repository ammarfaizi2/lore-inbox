Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbRETX7r>; Sun, 20 May 2001 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262274AbRETX7g>; Sun, 20 May 2001 19:59:36 -0400
Received: from www.microgate.com ([216.30.46.105]:30219 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S262272AbRETX7Y>; Sun, 20 May 2001 19:59:24 -0400
Message-ID: <006f01c0e188$f22fe1c0$0201a8c0@mojo>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E151ZTj-0002pT-00@the-village.bc.nu>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Date: Sun, 20 May 2001 18:59:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 90% of drivers contain code written by stupid gits.
>
> From: "Alan Cox"
> I think thats a very arrogant and very mistaken view of the problem. 90%
> of the driver are written by people who are
> 
> - Copying from other drivers
> - Using the existing API's to make their job easy
> - Working to timescales
> - Just want it to work

I'll be the first to admit there is some ugliness in my driver.

Some originates from accepted methods when the
driver originated. (points 1 and 2 above)

Some comes from doing new things with only the
existing infrastructure, because changing the infrastructure
is deemed too intrusive. (points 3 and 4 above)
Stable infrastructure is good, but sometimes ugliness results.

Some is the result of genuine mistakes (people who
have written nothing but perfect code flame away).
I fix these as they are found through use and review,
and the code improves. (I *really do* want my driver to work!)

As new facilities and guidelines are made available,
I *gladly* and *gratefully* use them, and the code improves.

Calling driver writers stupid and devising punitive measures
to 'cause them pain' seems less useful.

Paul Fulghum paulkf@microgate.com
Microgate Corporation http://www.microgate.com


