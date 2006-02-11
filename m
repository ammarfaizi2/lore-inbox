Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWBKJBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWBKJBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWBKJBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:01:24 -0500
Received: from smtpout.mac.com ([17.250.248.88]:15093 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932283AbWBKJBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:01:23 -0500
In-Reply-To: <20060210224238.GA5713@stiffy.osknowledge.org>
References: <20060210214122.GA13881@stiffy.osknowledge.org> <20060210222515.GA4793@mipter.zuzino.mipt.ru> <20060210224238.GA5713@stiffy.osknowledge.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <269F4ADB-FA82-47DD-9087-D07CA11DD681@mac.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Linux-LKLM <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual address e1380288
Date: Sat, 11 Feb 2006 04:01:16 -0500
To: Marc Koschewski <marc@osknowledge.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2006, at 17:42, Marc Koschewski wrote:
> * Alexey Dobriyan <adobriyan@gmail.com> [2006-02-11 01:25:15 +0300]:
>
>> On Fri, Feb 10, 2006 at 10:41:22PM +0100, Marc Koschewski wrote:
>>> I just wanted to mount an external USB HDD... this was what I got:
>>> [4297455.819000] EIP:    0060:[<c01ee88e>]    Tainted: P      VLI
>>
>> Kindly reproduce without proprietary modules loaded.
>
> I knew this would be the response. :)

So why did you bother posting in the first place?
   Patient:  Doctor, it hurts when I do this.
   Doctor:   So don't do that!
   Patient:  I knew that's what you'd say!
   Doctor:   ... so why'd you waste my time?

> Unfortunately I cannot reproduce. I just remounted the disk 6  
> times, via fstab and 'by hand'. Also rebooted with the thing  
> attached and just plugged it into the running system. No chance ...  
> always worked as expected.

Since you cannot reproduce your problem, we cannot help you.  I  
strongly suspect the proprietary module based on general suspicion  
and paranoia.  I recommend doing without it if possible.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


