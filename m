Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUGGPxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUGGPxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUGGPxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:53:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:52104 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265029AbUGGPxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:53:40 -0400
X-Authenticated: #4512188
Message-ID: <40EC1C85.9030008@gmx.de>
Date: Wed, 07 Jul 2004 17:53:41 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: John Richard Moser <nigelenki@comcast.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: Re: 2.6.7-ck5
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org>
In-Reply-To: <40EC1B0A.8090802@kolivas.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> John Richard Moser wrote:
>> When do you think the staircase, batch, and isometric scheduling will
>> reach mainline-quality?  Do you think you'll be ready to ask Andrew to
>> merge it soon, or will it be a while before it's quite ready for that?
> 
> 
> Well I think they're all ready for prime time now, I just dont think 
> prime time is ready for it. This is too large a change for mainline 2.6 
> which keeps -ck in business ;)

I don't know whether this was already discussed, but what about adding 
framework so that (like io-schedulers) the cpu scheduler could be chosen 
on boot time? This would make it easy to test different cpu schedulers.

Cheers,

Prakash
