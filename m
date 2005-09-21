Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVIUBNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVIUBNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVIUBNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:13:14 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:52315 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932089AbVIUBNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:13:13 -0400
Message-ID: <4330B388.8010307@emc.com>
Date: Tue, 20 Sep 2005 21:12:40 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: vitaly@thebsh.namesys.com, "Theodore Ts'o" <tytso@mit.edu>,
       Pavel Machek <pavel@suse.cz>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz> <20050921000425.GF6179@thunk.org> <4330A8F2.7010903@emc.com> <4330ACE2.8000909@namesys.com>
In-Reply-To: <4330ACE2.8000909@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.20.33
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Ric Wheeler wrote:
> 
> 
>>As an earlier thread on lkml showed this summer, we still have a long
>>way to go to getting consistent error semantics in face of media
>>failures between the various file systems.  I am not sure that we even
>>have consensus on what that default behavior should be between
>>developers, so image how difficult life is for application writers who
>>want to try to ride through or write automated "HA" recovery scripts
>>for systems with large numbers of occasionally flaky IO devices ;-)
> 
> 
> If you'd like to form a committee to standardize these things, I will
> ask Vitaly to work with you on that committee, and to have ReiserFS3+4
> conform to the standards that result.
> 
> Hans

I am not a big fan of formal committees, but would be happy to take part 
in any effort to standardize, code and test the result...

ric

