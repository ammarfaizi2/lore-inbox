Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVIURhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVIURhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVIURhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:37:05 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:43971 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751296AbVIURhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:37:01 -0400
Message-ID: <43319A2B.3050707@namesys.com>
Date: Wed, 21 Sep 2005 10:36:43 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ric Wheeler <ric@emc.com>
CC: gmaxwell@gmail.com, vitaly@thebsh.namesys.com,
       "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>	 <20050921000425.GF6179@thunk.org> <4330A8F2.7010903@emc.com>	 <4330ACE2.8000909@namesys.com> <4330B388.8010307@emc.com>	 <4330CDF1.4050902@namesys.com> <e692861c05092021552d39cecc@mail.gmail.com> <43314242.1050802@emc.com>
In-Reply-To: <43314242.1050802@emc.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ric Wheeler wrote:

> Gregory Maxwell wrote:
>
>> On 9/20/05, Hans Reiser <reiser@namesys.com> wrote:
>>  
>>
>>
>> Another goal of the group should be to formulate a requested set of
>> changes or extensions to the makers of drives and other storage
>> systems.  For example, it might be advantageous to be able to disable
>> bad block relocation and allow the filesystem to perform the action.
>> The reason for this is because relocates slaughter streaming read
>> performance, but the filesystem could still contiguously allocate
>> around them...
>>
>>  
>>
The words were attributed to me, but were not mine.

Sometimes mua's do that to one.

