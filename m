Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262642AbTCUBVQ>; Thu, 20 Mar 2003 20:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCUBVQ>; Thu, 20 Mar 2003 20:21:16 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:33298
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S262642AbTCUBVP>; Thu, 20 Mar 2003 20:21:15 -0500
Message-ID: <3E7A6B4F.1000205@rackable.com>
Date: Thu, 20 Mar 2003 17:30:55 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Andrew Morton <akpm@digeo.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Release of 2.4.21
References: <200303210013.h2L0D0jx000566@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2003 01:32:05.0821 (UTC) FILETIME=[AE72DED0:01C2EF49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

>>>>For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
>>>>the 2.4.21-pre cycle, that would be less productive than just patching
>>>>2.4.20 and rolling a separate release off of that.
>>>>        
>>>>
>>>I think the naming is illogical.  If there's a bugfix-only release
>>>it whould have normal incremental numbers.  So if marcelo want's
>>>it he should clone a tree of at 2.4.20, apply the essential patches
>>>and bump the version number in the normal 2.4 tree to 2.4.22-pre1
>>>      
>>>
>>No point in making things too complex.  2.4.20-post1 is something people can
>>easily understand.
>>
>>I needed that for the ext3 problems which popped up shortly after 2.4.20 was
>>released - I was reduced to asking people to download fixes from my web page.
>>
>>And having a -post stream may allow us to be a bit more adventurous in the
>>-pre stream.
>>    
>>
>
>Why can't we just make all releases smaller and more frequent?
>
>Why do we need 2.4.x-pre at all, anyway - why can't we just test
>things in the -[a-z][a-z] trees, and _start_ with -rc1?
>
>Why can't we just do bugfixes for 2.4, and speed up 2.5 development?
>
>  
>

  That would imply some changes could take place in a short cycle.  This 
is not true for things like major ide subsystem updates.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



