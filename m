Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTKZJSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 04:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTKZJSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 04:18:13 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:38112 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S264093AbTKZJSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 04:18:12 -0500
Message-ID: <3FC46FD0.8020504@softhome.net>
Date: Wed, 26 Nov 2003 10:18:08 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pascal Schmidt <der.eremit@email.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc5
References: <VOyg.w9.13@gated-at.bofh.it> <VOyg.w9.11@gated-at.bofh.it> <E1AOgfB-0000OY-00@neptune.local>
In-Reply-To: <E1AOgfB-0000OY-00@neptune.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt wrote:
> On Tue, 25 Nov 2003 17:50:20 +0100, you wrote in linux.kernel:
> 
>>   "overcommit_memory < 0" supposed to not allow apps to overallocate 
>>memory - but still it works not like it is said in 
>>Documentation/filesystems/proc.txt.
> 
> 
> That file mentiones setting overcommit_memory to 0 to disable overcommit.
> Have you tried that?
> 

   Yes. This is kernel default on all my systems.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

