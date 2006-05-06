Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWEFXXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWEFXXN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 19:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWEFXXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 19:23:13 -0400
Received: from science.horizon.com ([192.35.100.1]:40493 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750963AbWEFXXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 19:23:13 -0400
Date: 6 May 2006 19:23:11 -0400
Message-ID: <20060506232311.7353.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Correct.  He is violating the license in a number of ways, though it
>>> probably isn't totally intentional.
>>
>> Removing copyright and licence statements can't have been anything BUT
>> intentional.
>> 
>> That's really a basic rule, pretty much a "programming 101" thing.  You
>> know, like "test your code", "don't remove other folks' copyrights",
>> "don't try to change the licence on code copyrighted by someone else".

That's programming 101 in a litigous country.  Some people are lucky
enough to live in places where the law is treated with the respect
it deserves.

> Well, I suspect that poor soul did not know what (s)he was doing. They
> are clearly trying to do the right thing... just paste back original
> copyrights and be done with it.

> No need to pull them into the loop, I'd say. What they done is wrong,
> but we can correct it without their help.

I'm with Pavel.  This was probably done by some underpaid junior coder
in Bangalore who is utterly innocent of law, much less international law.

The point is, they didn't try to claim it's proprietary and a trade secret.
Misplacing the credit is very rude, but also easily fixable, especially
once the duplicate code is properly factored out.

A mention of "you shouldn't do that" is appropriate, but harassing a party
who's basically being cooperative is unnecessary and counterproductive.

A lot of expensive stonewalling in courts is caused by the fact that
it's dangerous to admit that you did anything wrong; it has very little
benefit, and lawyers proceed to just twist it into "and what else *aren't*
they admitting to?"  Unless you want to encourage that behaviour,
please don't make their lawyers regret that they let the source code
out with the incriminating lack-of-comments.  Just fix it and move on.

Save your righteous ire for the hard cases at gpl-violations.org.
