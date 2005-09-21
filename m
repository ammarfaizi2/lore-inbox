Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVIUDFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVIUDFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 23:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIUDFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 23:05:22 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:9695 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750733AbVIUDFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 23:05:21 -0400
Message-ID: <4330CDF1.4050902@namesys.com>
Date: Tue, 20 Sep 2005 20:05:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ric Wheeler <ric@emc.com>
CC: vitaly@thebsh.namesys.com, "Theodore Ts'o" <tytso@mit.edu>,
       Pavel Machek <pavel@suse.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <20050921000425.GF6179@thunk.org> <4330A8F2.7010903@emc.com> <4330ACE2.8000909@namesys.com> <4330B388.8010307@emc.com>
In-Reply-To: <4330B388.8010307@emc.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ric Wheeler wrote:

> Hans Reiser wrote:
>
>> Ric Wheeler wrote:
>>
>>
>>> As an earlier thread on lkml showed this summer, we still have a long
>>> way to go to getting consistent error semantics in face of media
>>> failures between the various file systems.  I am not sure that we even
>>> have consensus on what that default behavior should be between
>>> developers, so image how difficult life is for application writers who
>>> want to try to ride through or write automated "HA" recovery scripts
>>> for systems with large numbers of occasionally flaky IO devices ;-)
>>
>>
>>
>> If you'd like to form a committee to standardize these things, I will
>> ask Vitaly to work with you on that committee, and to have ReiserFS3+4
>> conform to the standards that result.
>>
>> Hans
>
>
> I am not a big fan of formal committees, but would be happy to take
> part in any effort to standardize, code and test the result...
>
> ric
>
>
>
The committee could simply exchange a set of emails, and agree on
things.  I doubt it needs to get all complicated.  I suggest you contact
all the folks you want to be consistent with each other, send us an
email asking us to all try to work together, and then ask for proposals
on what we should all conform to.  Distill the proposals, and then
suggest a common solution.  With luck, we will all just say yes.:)

Hans
