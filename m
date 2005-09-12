Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVILKjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVILKjF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVILKjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:39:05 -0400
Received: from dsw2k3.info ([195.71.86.227]:50412 "EHLO dsw2k3.info")
	by vger.kernel.org with ESMTP id S1750713AbVILKjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:39:04 -0400
Message-ID: <43255ABF.8080500@citd.de>
Date: Mon, 12 Sep 2005 12:38:55 +0200
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
Subject: Re: eth1394 and sbp2 maintainers
References: <43232875.4040702@s5r6.in-berlin.de> <20050911215504.17bc09a6.rdunlap@xenotime.net> <20050912074758.GB3863@ime.usp.br>
In-Reply-To: <20050912074758.GB3863@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> On Sep 11 2005, Randy.Dunlap wrote:
> 
>>Stefan,
>>
>>I want to say that I think that you are doing a very commendable
>>job on sbp2.  Much thanks for your efforts.
> 
> Let me add my voice to the choir here. I agree with Randy when he says
> that Stefan does a superb job supporting firewire with Linux.

Then let me be the voice telling about the flip-side.

I've used Firewire with SBP2-driver for nearly 4 years and most of the
time there was one problem or another (beginning from not-SMP-safe to
"plainly not working" for nearly a year, where i had to downpatch
Firewire (The nodemanager "desaster") for a very long time)

When the last problem crept up (sbp2-module couldn't be unloaded if only
a none-HDD-device was connected) i was so feed up with the continuous
hassle that i completly replaced my firewire hardware with USB2 Hardware.

With USB pluging/unplugging works flawlessly (couldn't say that for 4
years Firewire). Operating several devices concurrently works flawlessly
(I was lucky when my 2 devices worked concurrently with Firewire. Most
of the time only 1 device couldn't be connected without risking
desaster), in constrast i've had 10 HDDs running concurrently connected
via USB2 without a problem!

I know that i may have skipped the time where USB hasn't been mature to
the time where USB was mature, but it got there. So forgive me when i'm
too negative about firewire and too positive about USB.

To say it short:
- Firewire and especially SBP2 haven't been very mature in my 4 YEARS(!)
using it.
- As far as i see the userbase just isn't big enough to make it mature.

Taking aside some niche usages, i guess firewire WILL DIE because of USB
sooner then later. For me firewire died 6 month ago. Rest in peace.





-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

