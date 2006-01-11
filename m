Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWAKBi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWAKBi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWAKBi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:38:27 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:10772 "EHLO
	BAYC1-PASMTP11.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932769AbWAKBi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:38:26 -0500
Message-ID: <BAYC1-PASMTP11D76F1C8E40096264A62CAE240@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <46118.10.10.10.28.1136943503.squirrel@linux1>
In-Reply-To: <20060111005721.GA29663@stusta.de>
References: <cbec11ac0512201343q79de6e13h6fccf1259445076@mail.gmail.com>
    <20060111005721.GA29663@stusta.de>
Date: Tue, 10 Jan 2006 20:38:23 -0500 (EST)
Subject: Re: Revised [PATCH] Documentation: Update to SubmittingPatches
From: "Sean" <seanlkml@sympatico.ca>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Ian McDonald" <imcdnzl@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 11 Jan 2006 01:39:53.0453 (UTC) FILETIME=[EB6B19D0:01C6164F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, January 10, 2006 7:57 pm, Adrian Bunk said:

>> -Use "diff -up" or "diff -uprN" to create patches.
>> +You can use git-diff(1) or git-format-patch(1) which makes your life
>> easy. If
>> +you want it to be more difficult then carry on reading.
>>...
>
> IMHO, this doesn't make much sense:
>
> The average patch submitter does _not_ use git in any way - and there's
> no reason why he should.
>

Git is an efficient and convenient way to track the mainline kernel.   The
number of submitters using it is significant enough to mention it as an
option for creating patches.

Sean

