Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbRCATML>; Thu, 1 Mar 2001 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129816AbRCATME>; Thu, 1 Mar 2001 14:12:04 -0500
Received: from idiom.com ([216.240.32.1]:12293 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S129809AbRCATLw>;
	Thu, 1 Mar 2001 14:11:52 -0500
Message-ID: <3A9E972D.CEA149B0@namesys.com>
Date: Thu, 01 Mar 2001 21:38:37 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: James Lewis Nance <jlnance@intrex.net>
CC: linux-kernel@vger.kernel.org,
        brian jenkins <bjenkins@thresholdnetworks.com>,
        dave hecht <dhecht@thresholdnetworks.com>,
        Nikita Danilov <god@namesys.com>
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
In-Reply-To: <3A9D891C.434E3AA7@namesys.com> <20010301121554.A861@bessie.dyndns.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Lewis Nance wrote:
> 
> On Thu, Mar 01, 2001 at 02:26:20AM +0300, Hans Reiser wrote:
> > I have a client that wants to implement a webcache, but is very leery of
> > implementing it on Linux rather than BSD.
> >
> > They know that iMimic's polymix performance on Linux 2.2.* is half what it
> > is on BSD.  Has the Linux 2.4 networking code caught up to BSD?
> >
> > Can I tell them not to worry about the Linux networking code strangling their
> > webcache product's performance, or not?
> 
> Hi Hans,
>     I dont have an answer for you, but it would be nice to know the answer.
> Would it be difficult to measure this?  It should not be difficult to make
> a machine dual boot Linux and BSD, and then we can measure the differences.
> If there is a significant performance difference either way then we can
> try and investigate it to see why.
> 
> Thanks,
> 
> Jim

This is indeed what we should do if we get no answer from the list by someone
who has already done such work.

Hans
