Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSFTRQl>; Thu, 20 Jun 2002 13:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSFTRQk>; Thu, 20 Jun 2002 13:16:40 -0400
Received: from hq.tensilica.com ([65.205.227.29]:62707 "EHLO
	mail-in.hq.tensilica.com") by vger.kernel.org with ESMTP
	id <S315279AbSFTRQk>; Thu, 20 Jun 2002 13:16:40 -0400
Message-ID: <3D120DEB.5040304@tensilica.com>
Date: Thu, 20 Jun 2002 10:16:27 -0700
From: RW Hawkins <rw@tensilica.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com> <m1d6umtxe8.fsf@frodo.biederman.org> <20020620103003.C6243@host110.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're missing the point. Larry is saying "I have been down this road 
before, take heed". We don't want to waste the time reinventing bloat 
when we can learn from others mistakes.

-RW

 Cort Dougan wrote:

>"Beating the SMP horse to death" does make sense for 2 processor SMP
>machines.  When 64 processor machines become commodity (Linux is a
>commodity hardware OS) something will have to be done.  When research
>groups put Linux on 1k processors - it's an experiment.  I don't think they
>have much right to complain that Linux doesn't scale up to that level -
>it's not designed to.
>
>That being said, large clusters are an interesting research area but it is
>_not_ a failing of Linux that it doesn't scale to them.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>



