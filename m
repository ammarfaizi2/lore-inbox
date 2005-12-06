Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbVLFAX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbVLFAX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVLFAX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:23:59 -0500
Received: from mail-haw.bigfish.com ([12.129.199.61]:13411 "EHLO
	mail31-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751518AbVLFAX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:23:58 -0500
X-BigFish: V
Message-ID: <4394DA1D.3090007@am.sony.com>
Date: Mon, 05 Dec 2005 16:23:57 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: "Bird, Tim" <Tim.Bird@am.sony.com>, David Woodhouse <dwmw2@infradead.org>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
In-Reply-To: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
>>To the larger argument about supporting binary drivers,
>>all Arjan manages to prove with his post is that,
>>if handled in the worst possible way, support for
>>binary drivers would be a disaster.  Who can disagree
>>with that?
>> 
> And do you think that given the opportunity, any company is going
> spend the extra money required to not do it in the worst possible
> way?? 

I meant "handled in the worst possible way by
the kernel developers".  It *is* possible to define
stable APIs and have them used successfully.

POSIX is not the greatest example, but it seems
to work OK.  I realize that drivers are more
tightly bound to the kernel than are libraries
or applications, but sheesh, this is not rocket
science.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

