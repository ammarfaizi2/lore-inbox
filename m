Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbSJCPSb>; Thu, 3 Oct 2002 11:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbSJCPRK>; Thu, 3 Oct 2002 11:17:10 -0400
Received: from [203.117.131.12] ([203.117.131.12]:41088 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261606AbSJCPQk>; Thu, 3 Oct 2002 11:16:40 -0400
Message-ID: <3D9C6099.9060504@metaparadigm.com>
Date: Thu, 03 Oct 2002 23:22:01 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Shawn <core@enodev.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
       Andreas Dilger <adilger@clusterfs.com>,
       Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
References: <Pine.GSO.4.21.0210021922200.13480-100000@weyl.math.psu.edu> <3D9BDA8D.5080700@metaparadigm.com> <1033648730.28022.8.camel@irongate.swansea.linux.org.uk> <3D9C4FA8.10201@metaparadigm.com> <20021003100702.C32461@q.mn.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/02 23:07, Shawn wrote:
> On 10/03, Michael Clark said something like:
> 
>>On 10/03/02 20:38, Alan Cox wrote:
>>
>>>On Thu, 2002-10-03 at 06:50, Michael Clark wrote:
>>>
>>>
>>>>>... and you don't need EVMS for that.
>>>>
>>>>But EVMS would be an excellent substitute in the mean time.
>>>>
>>>>Better to having something excellent now than something perfect but
>>>>too late.
>>>
> 
> This statement is misleading; in no way is EVMS intended as an
> interim solution to a problem addressed easier in other ways. It's
> a fundamental change which happens to address certain critical issues
> and also adds functionality whiz-bangs.

Yes, i agree. It's not the original intention of EVMS to be used
as a unified interface to all linux block devices. Although it
could be used in that way if desired by any individual user -
to provide a solution to the consistent block device naming issue.

>>>You can see who around here has maintained kernel code and who hasnt.
>>>You don't want a substitute in the mean time, because then you have to
>>>get rid of it
>>
>>Like LVM ;)
> 
> 
> Not quite...

Well, existing LVM does appear to be a subsitute for a better solution
(dm or EVMS) for which it's time has come to be removed.

~mc

