Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSBMQTz>; Wed, 13 Feb 2002 11:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSBMQTp>; Wed, 13 Feb 2002 11:19:45 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:45491 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287450AbSBMQTe>; Wed, 13 Feb 2002 11:19:34 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is a livelock? (was: [patch] sys_sync livelock fix)
In-Reply-To: <3C69A18A.501BAD42@zip.com.au> <3C69A18A.501BAD42@zip.com.au>
	<87y9hyw4b6.fsf@tigram.bogus.local> <3C69C7E9.E01C3532@zip.com.au>
	<87pu3aw1ue.fsf@tigram.bogus.local> <3C69D1FC.195CD36@zip.com.au>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Wed, 13 Feb 2002 17:19:00 +0100
Message-ID: <87bsetwe17.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Olaf Dietsche wrote:
>> 
>> I still don't get it :-(. When there is more work, this more work
>> needs to be done. So, how could livelock be considered a bug? It's
>> just overload. Or is this about the work, which must be done _after_
>> the queue is empty?
>> 
> ...
> [good explanation, so even I grasped it :-)]

Thanks to all, who tried hard explaining livelock.

Regards, Olaf.
