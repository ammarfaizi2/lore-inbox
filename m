Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280997AbRKOTD1>; Thu, 15 Nov 2001 14:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280996AbRKOTDR>; Thu, 15 Nov 2001 14:03:17 -0500
Received: from jackie.iddl.vt.edu ([128.173.53.192]:3246 "EHLO
	jackie.iddl.vt.edu") by vger.kernel.org with ESMTP
	id <S280997AbRKOTDG>; Thu, 15 Nov 2001 14:03:06 -0500
Message-ID: <3BF41165.4090206@vt.edu>
Date: Thu, 15 Nov 2001 14:03:01 -0500
From: Jackie Meese <jackie.m@vt.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 32 Groups Maximum in 2.4
In-Reply-To: <3BF3DF31.4010707@vt.edu> <20011115113953.H5739@lynx.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> On Nov 15, 2001  10:28 -0500, Jackie Meese wrote:
> 
>>I've been looking for some time on how to raise the maximum number of 
>>groups for the 2.4 kernel.  I've discovered how to do this kernel, with 
>>a discussion a few months ago on this 
>>list.http://www.cs.helsinki.fi/linux/linux-kernel/2001-13/0807.html
>>
> 
> Have you considered ACLs instead?  http://acl.bestbits.at/
> Also available for ext3 (I think reiserfs may also support ACLs, not sure).
> It might not suit your needs, but maybe it does, and it is a better long-term
> solution.


The current backup software used for our servers is one big reason for 
writing off ACL fairly quickly.  Having to check for compatability on 
other software we use is another reason this was ruled out.

-- 
Jackie Meese	Institute for Distance and Distributed Learning, Va Tech
Phone: 231-3682	3027 Torgersen Hall MailCode:0445 http://www.iddl.vt.edu/
Education is the change in behavior that occurs as the result of
interaction with events in ones environment.

