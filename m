Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUG0T7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUG0T7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUG0T7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:59:17 -0400
Received: from mail.tmr.com ([216.238.38.203]:1036 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266535AbUG0T7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:59:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Delete cryptoloop
Date: Tue, 27 Jul 2004 16:02:09 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6bs6$i0r$1@gatekeeper.tmr.com>
References: <1090672906.8587.66.camel@ghanima><Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040724095245.73ca26fe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090958022 18459 192.168.12.100 (27 Jul 2004 19:53:42 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040724095245.73ca26fe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
> 
>>So much for cryptoloop.
> 
> 
> I think I'd rather add a patch which does printk("cryptoloop will be
> removed from Linux on June 30, 2005.  Please migrate to dm-crypt")

A number of things in 2.4 were left alone until 2.6, other than getting 
lots of people to stay with old kernels why do you object to waiting to 
remove this feature in 2.7?

"mount ~/mycrypt" is simple enough for a user to use, dm-crypt is not 
remotely easy to use, not to mention that the tools all need to be added 
  to the install on every machine.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
