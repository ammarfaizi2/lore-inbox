Return-Path: <linux-kernel-owner+w=401wt.eu-S965025AbWLMQr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWLMQr3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWLMQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:47:29 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:27323 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965025AbWLMQr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:47:28 -0500
X-Greylist: delayed 4028 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:47:28 EST
Date: Wed, 13 Dec 2006 10:37:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Postgrey experiment at VGER
In-reply-to: <200612131711.28292.a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Cc: Al Boldi <a1426z@gawab.com>
Message-id: <200612131037.12592.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200612131711.28292.a1426z@gawab.com>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 December 2006 09:11, Al Boldi wrote:
>Trond Myklebust wrote:
>> On Wed, 2006-12-13 at 11:25 +0200, Dumitru Ciobarcianu wrote:
>> > On Wed, 2006-12-13 at 01:50 +0200, Matti Aarnio wrote:
>> > > I do already see spammers smart enough to retry addresses from
>> > > the zombie machine, but that share is now below 10% of all emails.
>> > > My prediction for next 200 days is that most spammers get the
>> > > clue, but it gives us perhaps 3 months of less leaked junk.
>
>Great!
>
>> > IMHO this is only an step in an "arms race".
>> > What you will do in three months, remove this check because it will
>> > prove useless since the spammers will also retry ? If yes, why
>> > install it in the first place ?
>>
>> Why ever do anything? You're going to die eventually anyway...
>
Some of sooner than others, since we're well on the way anyway. :)

>Right!  The problem here is that it may do more harm than good.
>
>May I suggest a smarter way to filter these spammers, by just
> whitelisting email addresses of valid posters, after sending a
> confirmation for the first post.  Now if these spammers get smart, and
> start using personal email addresses, I would certainly expect some
> real action by abused email address owners.

This one I second wholeheartedly.  Because its entirely possible that my 
isp's server will not retry, but will probably spend the next 3 days 
emailing me failure notices every 3 hours or so.  They also have their 
own blacklist for incoming that I've had to bitch about, at length 
because the only way to get around it is to change my email address to a 
special one they maintain.   Theres only one fly in that solution that 
makes the soup unpalatable, I can't send using that address in my headers 
as its an unknown user error to their outgoing.verizon.net servers .  I'm 
on vz, go figure.

My first reply since, so this is a test of sorts.

>
>Thanks!
>
>--
>Al
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
