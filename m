Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTB0HIN>; Thu, 27 Feb 2003 02:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTB0HIM>; Thu, 27 Feb 2003 02:08:12 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:25587 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S261451AbTB0HIM>; Thu, 27 Feb 2003 02:08:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ion Badulescu <ionut@badula.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box! 
In-reply-to: Your message of "Wed, 26 Feb 2003 16:00:49 -0800."
             <Pine.LNX.4.44.0302261559170.3527-100000@home.transmeta.com> 
Date: Thu, 27 Feb 2003 18:17:57 +1100
Message-Id: <E18oIIn-0007ef-00@bach>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302261559170.3527-100000@home.transmeta.com> you wri
te:
> 
> Ok, can people agree on this simplified version of Mikaels patch, which 
> doesn't BUG_ON(), and doesn't reset 'boot_cpu_physical_apicid' 
> unnecessarily..
> 
> Does this work for people?

Yes!

Wow, now I feel sorry about breaking module.c on you.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
