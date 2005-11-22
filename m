Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVKVLiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVKVLiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVKVLiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:38:09 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:61594 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751286AbVKVLiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:38:08 -0500
Date: Tue, 22 Nov 2005 11:38:04 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Alexander Clouter <alex@digriz.org.uk>
cc: Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, blaisorblade@yahoo.it, davej@codemonkey.org.uk,
       davej@redhat.com
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of
 'ignore nice'
In-Reply-To: <20051122085234.GA2487@inskipp.digriz.org.uk>
Message-ID: <Pine.LNX.4.63.0511221133420.26358@deepthought.mydomain>
References: <20051121181722.GA2599@inskipp.digriz.org.uk>
 <Pine.LNX.4.63.0511220102330.18504@deepthought.mydomain>
 <20051122085234.GA2487@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-899712621-1132659330=:26358"
Content-ID: <Pine.LNX.4.63.0511221135580.26358@deepthought.mydomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-899712621-1132659330=:26358
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.63.0511221135581.26358@deepthought.mydomain>

Hi Alex,

On Tue, 22 Nov 2005, Alexander Clouter wrote:

> Morning Ken,
>
> Ken Moffat <zarniwhoop@ntlworld.com> [20051122 01:21:18 +0000]:
>>
>> On Mon, 21 Nov 2005, Alexander Clouter wrote:
>>
> Con complained about that one too, rightly so.  If you look more recently you
> will see that the default is actually now '0' so nice'd processes do count
> towards the business calculation....I guess I could submit *another* more or
> less duplicate patch to really confuse things to rename the sysfs entry again
> and it to expect a huge prime number to ignore nice'd processes ;)
>
> Guess you can go back to your initscript and remove that entry :P
>
> Cheers
>
> Alex
>

  If the default is that nice'd processes do count, then I'm happy (and 
I've yet again showed my lack of understanding).  Thanks.

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-899712621-1132659330=:26358--
