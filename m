Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274958AbTHGA1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274968AbTHGA1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:27:18 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:44303 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S274958AbTHGA1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:27:14 -0400
Message-ID: <3F319FE5.2090801@techsource.com>
Date: Wed, 06 Aug 2003 20:40:05 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
References: <3F306858.1040202@mrs.umn.edu> <20030805224152.528f2244.akpm@osdl.org> <3F310B6D.6010608@namesys.com> <3F319146.6080607@techsource.com> <20030806234704.GI21290@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:
> On Wed, Aug 06, 2003 at 07:37:42PM -0400, Timothy Miller wrote:
> 
>>
>>Hans Reiser wrote:
>>
>>
>>>reiser4 cpu consumption is still dropping rapidly as others and I find 
>>>kruft in the code and remove it.  Major kruft remains still.
>>
> 
>>Now, if you can manage to make it twice as fast while NOT increasing the 
>>CPU usage, well, then that's brilliant, but the fact that ReiserFS uses 
>>more CPU doesn't bother me in the least.
> 
> 
> Basically he's saying it's faster and still not at its peak effeciency yet
> too.

That point was already clear to me.  I guess I was rather unclear about 
MY point.  :)  I wasn't talking to Hans so much as anyone who might 
worry about CPU usage for a FS.



