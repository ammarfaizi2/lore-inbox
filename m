Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310990AbSCMTaB>; Wed, 13 Mar 2002 14:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311072AbSCMT3v>; Wed, 13 Mar 2002 14:29:51 -0500
Received: from [208.179.59.195] ([208.179.59.195]:10535 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S310990AbSCMT3k>; Wed, 13 Mar 2002 14:29:40 -0500
Message-ID: <3C8FA87C.70808@blue-labs.org>
Date: Wed, 13 Mar 2002 14:29:00 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020309
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Robert Love <rml@tech9.net>, Brian S Queen <bqueen@nas.nasa.gov>,
        linux-kernel@vger.kernel.org
Subject: Re: Upgrading Headers?
In-Reply-To: <1015895241.928.107.camel@phantasy>  <200203120100.RAA00468@marcy.nas.nasa.gov> <6468.1015927347@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may be ill-advised, but it hasn't been 'broken' for the last several 
years.

-d

David Woodhouse wrote:

>rml@tech9.net said:
>
>> You don't.  The headers in /usr/include/linux and /usr/include/asm
>>(which may be a symlink to /usr/src/linux/include/linux and /usr/src/
>>linux/include/asm, respectively) should point to the kernel headers
>>that were present when _glibc_ was compiled. 
>>
>
>No it may not be a symlink. That would be broken.
>


