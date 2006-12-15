Return-Path: <linux-kernel-owner+w=401wt.eu-S965234AbWLOWDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbWLOWDH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWLOWDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:03:06 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:35788 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965235AbWLOWDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:03:04 -0500
Date: Fri, 15 Dec 2006 22:59:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
       Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/v2] CodingStyle updates
In-Reply-To: <20061215212724.GB317@lazybastard.org>
Message-ID: <Pine.LNX.4.61.0612152255400.28506@yvahk01.tjqt.qr>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com>
 <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de>
 <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
 <20061215150717.GA2345@elf.ucw.cz> <20061215090037.05c021af.randy.dunlap@oracle.com>
 <20061215201127.GA32210@lazybastard.org> <d120d5000612151256h5428eddcpbd137ce939a58b32@mail.gmail.com>
 <Pine.LNX.4.61.0612152158240.28506@yvahk01.tjqt.qr> <20061215212724.GB317@lazybastard.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-455265087-1166219948=:28506"
Content-ID: <Pine.LNX.4.61.0612152259120.28506@yvahk01.tjqt.qr>
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-455265087-1166219948=:28506
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.61.0612152259121.28506@yvahk01.tjqt.qr>


On Dec 15 2006 21:27, Jörn Engel wrote:
>On Fri, 15 December 2006 22:01:10 +0100, Jan Engelhardt wrote:
>> On Dec 15 2006 15:56, Dmitry Torokhov wrote:
>> >
>> > outside the loop? If not then it is better to keep style consistent
>> > and not use condensed form in loops either.
>> 
>> Don't you all even think about leaving the whitespace away in the wrong
>> place, otherwise the kernel is likely to become an entry for IOCCC.
>
>Please, this is not religion.  No god has spoken "though shalt not...".
>
>In 99% of all cases, what Randy wrote is the best choice.  But the

Of course it is - hey, I even "contributed" to it. Well, looks like I should be
adding in more smilies when making remarks like the above.

>ultimate goal is not to follow his heavenly rules with fundamental
>zealotry, the ultimate goal is to make the code readable.  If you
>happen to stumble on the 1% case where the code can be more readable by
>not following the rules, and you are absolutely sure about that, then
>don't.  That simple. ;)

I take it that people will automatically DTRT for obscure cases like
shown before. Well, and if they don't, hopefully some reviewer catches
things like 3*i + l<<2.

It's all right, I did not mean to step on toes.

	-`J'
-- 
--1283855629-455265087-1166219948=:28506--
