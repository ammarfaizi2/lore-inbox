Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUBDUNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264583AbUBDUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:13:32 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:56476 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S264563AbUBDUNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:13:09 -0500
Message-ID: <40215246.2030404@mnsu.edu>
Date: Wed, 04 Feb 2004 14:12:54 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jan Dittmer <j.dittmer@portrix.net>, Simon Gate <simon@noir.se>
Subject: Re: Orinoco in 2.6.1
References: <20040204151532.0b81878d.simon@noir.se> <40210D6C.1020405@portrix.net>
In-Reply-To: <40210D6C.1020405@portrix.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can the paches for the Orinoco monitor functions found at 
http://airsnort.shmoo.com/orinocoinfo.html
be merged into the standard kernel?  I ran the patches for most of the 
2.4.x tree with no problems.  Is there a political or technical problem 
I don't see?

-- 
jeffrey hundstad


Jan Dittmer wrote:

> Simon Gate wrote:
>
>> Hey.
>>
>> Is there a patch to get the monitor function on my orinoco wireless 
>> card with 2.6.1?
>>
>
> I last tried it with test7, but back then the patches from
>
> http://airsnort.shmoo.com/orinocoinfo.html
>
> just worked (applied with -p1 in the drivers/net/wireless directory).
>
> Regards,
>
> Jan

