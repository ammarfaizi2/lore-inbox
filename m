Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311484AbSCNCzs>; Wed, 13 Mar 2002 21:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311485AbSCNCzh>; Wed, 13 Mar 2002 21:55:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15372 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311484AbSCNCzX>;
	Wed, 13 Mar 2002 21:55:23 -0500
Message-ID: <3C901105.5040605@mandrakesoft.com>
Date: Wed, 13 Mar 2002 21:55:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dan Kegel <dkegel@ixiacom.com>, Ulrich Drepper <drepper@redhat.com>,
        darkeye@tyrell.hu, libc-gnats@gnu.org, gnats-admin@cygnus.com,
        sam@zoy.org, Xavier Leroy <Xavier.Leroy@inria.fr>,
        linux-kernel@vger.kernel.org, babt@us.ibm.com
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the problem
In-Reply-To: <E16lLTa-0008BN-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I'm all in favor of a userspace fix.  I suggested a patch
>>to glibc to fix this.  Ulrich rejected it; I'm trying
>>to coax out of him how he thinks profiling of multithreaded
>>programs on Linux should be fixed.
>>
>
>Good and I'll reject any kernel patches 8)
>
>If Ulrich won't talk then talk to the NGPT people. Maybe a little
>competition will warm things up.
>
Talk about a small world, I just found out today someone I know has been 
maintaining the NGPT kernel patches :)

http://gtf.org/~dank/ngpt/

    Jeff





