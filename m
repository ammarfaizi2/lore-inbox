Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVKISvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVKISvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVKISvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:51:43 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:23764 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932344AbVKISvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:51:42 -0500
Message-ID: <437245A6.6030601@tmr.com>
Date: Wed, 09 Nov 2005 13:53:26 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Linux 2.6.14.1
References: <20051109010729.GA22439@kroah.com> <20051108211354.546e0163.akpm@osdl.org>
In-Reply-To: <20051108211354.546e0163.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> 
>>We (the -stable team) are announcing the release of the 2.6.14.1 kernel.
> 
> 
> We need the fix for the net-drops-zero-length-udp-messages bug which broke
> bind and traceroute.

Yes, particularly since there's a security issue, people might not have 
found the patch to get their bind working and be holding off upgrade 
because of that.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
