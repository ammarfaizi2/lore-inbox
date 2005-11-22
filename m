Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVKVLnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVKVLnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKVLnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:43:09 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:56156 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751249AbVKVLnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:43:08 -0500
Date: Tue, 22 Nov 2005 11:43:04 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Con Kolivas <kernel@kolivas.org>
cc: Dave Jones <davej@redhat.com>, Ken Moffat <zarniwhoop@ntlworld.com>,
       Alexander Clouter <alex@digriz.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, blaisorblade@yahoo.it, davej@codemonkey.org.uk
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of
 'ignore nice'
In-Reply-To: <200511221331.45601.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.63.0511221138310.26358@deepthought.mydomain>
References: <20051121181722.GA2599@inskipp.digriz.org.uk>
 <Pine.LNX.4.63.0511220102330.18504@deepthought.mydomain> <20051122022215.GB1288@redhat.com>
 <200511221331.45601.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1174806078-1132659784=:26358"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1174806078-1132659784=:26358
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 22 Nov 2005, Con Kolivas wrote:

>> >  Just what have you cpufreq guys got against nice'd processes ?  It's
>> > enough to drive a man to powernowd ;)
>>
>> The opinion on this one started out with everyone saying "Yeah,
>> this is dumb, and should have changed". Now that the change appears
>> in a mergable patch, the opinion seems to have swung the other way.
>>
>> I'm seriously rethinking this change, as no matter what we do,
>> we're going to make some people unhappy, so changing the status quo
>> seems ultimately pointless.
>
> Eh? I thought he was agreeing with niced processes running full speed but that
> he misunderstood that that was the new default. Oh well I should have just
> shut up.
>
> Con
>

  Hi Con,

  looks as if I did misunderstand the default.  In the last week I've 
seen occasional comments on this from both sides of the debate, so I 
read the description and got it wrong.

  Now, if you gentlement will excuse me, I'll just wipe this egg off my 
face.

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-1174806078-1132659784=:26358--
