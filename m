Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRACUxs>; Wed, 3 Jan 2001 15:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131113AbRACUx2>; Wed, 3 Jan 2001 15:53:28 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:39688 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131111AbRACUxZ>;
	Wed, 3 Jan 2001 15:53:25 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101032021.f03KLwX394037@saturn.cs.uml.edu>
Subject: Re: SHM Not working in 2.4.0-prerelease
To: doug@wireboard.com (Doug McNaught)
Date: Wed, 3 Jan 2001 15:21:58 -0500 (EST)
Cc: shawn.starr@home.net, linux-kernel@vger.kernel.org
In-Reply-To: <m3g0j0l7e6.fsf@belphigor.mcnaught.org> from "Doug McNaught" at Jan 03, 2001 03:15:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> [spstarr@coredump /etc]$ free
>>              total       used       free     shared    buffers
...
>> the shmfs is mounted. Is there any configuration i need to get
>> shm memory activiated?
>
> The 'shared' field in /proc/meminfo (source for 'top' and 'free')
> has nothing to do with {SysV,POSIX} shared memory.

Hey, that would be a good use for the field.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
