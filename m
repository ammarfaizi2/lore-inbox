Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283360AbRLME4c>; Wed, 12 Dec 2001 23:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283379AbRLME4V>; Wed, 12 Dec 2001 23:56:21 -0500
Received: from tamqfl1-ar3-171-140.tamqfl1.dsl.gtei.net ([4.34.171.140]:46014
	"EHLO spanky.onsyd.com") by vger.kernel.org with ESMTP
	id <S283360AbRLME4D>; Wed, 12 Dec 2001 23:56:03 -0500
Message-ID: <2923.4.34.169.253.1008219348.squirrel@mail.onsyd.com>
Date: Wed, 12 Dec 2001 23:55:48 -0500 (EST)
Subject: Re: debian unstable and 2.4.16-pre8...
From: "Syd Alsobrook" <syd@onsyd.com>
To: <zoid@zoid.staticky.com>
In-Reply-To: <Pine.LNX.4.33.0112122343540.22255-100000@localhost>
In-Reply-To: <Pine.LNX.4.33.0112122343540.22255-100000@localhost>
Cc: <james.mayer@acm.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc1])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if it was a good idea but, I removed the line *(.text.exit)
from the /DISCARD/ : { section of arch/i386/vmlinux.lds and it compiled
without error.

Syd




> yeah, i did one just a lil' bit ago, and i'm still having the
> problem...now that it works for you i'm even more frustrated!
>
> --------------------------------------------------------------------------
------
>
> Rob Hensley
> E-email:      zoid@staticky.com
> Text Message: 5135186731@airtouch.net
>
> On Wed, 12 Dec 2001, James Mayer wrote:
>
>> Thanks for the .config -- it worked perfectly here.  Have you done an
>> apt-get update ; apt-get upgrade lately?
>>
>> --
>> "As a former philosophy major, it disturbs me to think that
>>  things disappear when no one is looking at them, but that's
>>  exactly what happens in Python."
>>    - Mark Pilgrim (www.diveintopython.com, section 3.4)
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



