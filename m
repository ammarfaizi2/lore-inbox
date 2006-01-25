Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWAYQ5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWAYQ5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWAYQ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:57:05 -0500
Received: from smtpout.mac.com ([17.250.248.97]:58578 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750970AbWAYQ5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:57:04 -0500
In-Reply-To: <43D7A7F4.nailDE92K7TJI@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Wed, 25 Jan 2006 11:56:37 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 25, 2006, at 11:31, Joerg Schilling wrote:
> Albert Cahalan <acahalan@gmail.com> wrote:
>> We Linux users will forever patch your software to work the
>
> Looks like you are not a native English speaker. "We" is incorrect  
> here, as you only speak for yourself.

I agree completely with his statements, therefore he speaks for at  
least two people and "we" is proper usage.  I suspect given the posts  
on this list the last time this flamewar came up that there are more  
as well, but 2 is enough.

> libscg includes...

Irrelevant to the discussion at hand, we are talking only about linux  
and what should be done on linux.

> - Only 5 of them allow a /dev/hd* device name related access.

No, you have this wrong:

- One of them (IE: Linux) requires a /dev/[hs]d* device-name related  
access

- Only 4 others allow /dev/hd*

However, the later is _completely_ _irrelevant_ to the discussion, as  
we are talking about Linux *only*.

> [irrelevant discussion of other platforms]

> 17 Platforms _need_ the addressing scheme libscg offers
> 5  Platforms _may_ use a different access method too.

Wrong again:
17 platforms need libscg's addressing
4 platforms offer /dev/* access
1 platform (Linux) _requires_ /dev/* access

You are perfectly free to adjust your compatibility layer accordingly.

> BTW: the wording of your posting [...]

Personal attacks are offtopic, irrelevant, and rude.  Please refrain  
from doing so.  If you don't plan to respond to somebody's email,  
just don't, no reason to shout about it to a world who doesn't care.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



