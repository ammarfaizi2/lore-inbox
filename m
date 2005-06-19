Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVFSQ6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVFSQ6h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 12:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVFSQ6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 12:58:37 -0400
Received: from smtpout.mac.com ([17.250.248.88]:2544 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261851AbVFSQ6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 12:58:34 -0400
In-Reply-To: <20050619082251.GA6483@redhat.com>
References: <20050617001330.294950ac.akpm@osdl.org> <1119016223.5049.3.camel@mulgrave> <20050617142225.GO6957@suse.de> <20050617141003.2abdd8e5.akpm@osdl.org> <20050617212338.GA16852@suse.de> <491950000.1119044739@flay> <20050618191341.GA30620@redhat.com> <265EC713-9745-484D-8FF0-1C8D5FFE94F1@mac.com> <20050619082251.GA6483@redhat.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6CC915C-418A-4992-B55C-73EF7A73085A@mac.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: kernel bugzilla
Date: Sun, 19 Jun 2005 12:58:21 -0400
To: Dave Jones <davej@redhat.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 19, 2005, at 04:22:51, Dave Jones wrote:

> On Sat, Jun 18, 2005 at 10:54:33PM -0400, Kyle Moffett wrote:
>> Another wishlist feature I've seen is to have a mailing list archiver
>> attached to bugzilla that receives and stores the last month worth of
>> emails on the list.  At any time someone can login and:
>>
>
> The volume of mail bugzilla-mail generates is obscene.
> I've been on vacation for a week, and I have over a 1000
> mails waiting for me from rh-bugzilla when I get back
> to give you an indication.[*]

I was thinking something more like an LKML archiver tied to bugzilla,
because I've seen a number of times where bugs get reported to the list
and then lost, causing the reported oops and other critical data to
fall by the wayside.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
  -- C.A.R. Hoare

