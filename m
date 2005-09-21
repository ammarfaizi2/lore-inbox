Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVIUSNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVIUSNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVIUSNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:13:35 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:53600 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751133AbVIUSNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:13:34 -0400
Message-ID: <4331A28E.1030107@emc.com>
Date: Wed, 21 Sep 2005 14:12:30 -0400
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: gmaxwell@gmail.com, vitaly@thebsh.namesys.com,
       "Theodore Ts'o" <tytso@mit.edu>, Pavel Machek <pavel@suse.cz>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>	 <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>	 <20050921000425.GF6179@thunk.org> <4330A8F2.7010903@emc.com>	 <4330ACE2.8000909@namesys.com> <4330B388.8010307@emc.com>	 <4330CDF1.4050902@namesys.com> <e692861c05092021552d39cecc@mail.gmail.com> <43314242.1050802@emc.com> <43319A2B.3050707@namesys.com>
In-Reply-To: <43319A2B.3050707@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.21.20
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_419_BADTHINGS 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Ric Wheeler wrote:
> 
> 
>>Gregory Maxwell wrote:
>>
>>
>>>On 9/20/05, Hans Reiser <reiser@namesys.com> wrote:
>>> 
>>>
>>>
>>>Another goal of the group should be to formulate a requested set of
>>>changes or extensions to the makers of drives and other storage
>>>systems.  For example, it might be advantageous to be able to disable
>>>bad block relocation and allow the filesystem to perform the action.
>>>The reason for this is because relocates slaughter streaming read
>>>performance, but the filesystem could still contiguously allocate
>>>around them...
>>>
>>> 
>>>
> 
> The words were attributed to me, but were not mine.
> 
> Sometimes mua's do that to one.
> 

Sorry - my error in trying to trim my response ended up trimming the 
proper attribution to Gregory,

ric

