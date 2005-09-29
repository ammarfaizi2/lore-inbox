Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVI2Tk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVI2Tk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVI2Tk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:40:29 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11524 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964857AbVI2Tk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:40:27 -0400
Message-ID: <433C4343.20205@tmr.com>
Date: Thu, 29 Sep 2005 15:40:51 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] CART - an advanced page replacement policy
References: <20050929180845.910895444@twins>
In-Reply-To: <20050929180845.910895444@twins>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Multiple memory zone CART implementation for Linux.
> An advanced page replacement policy.
> 
> http://www.almaden.ibm.com/cs/people/dmodha/clockfast.pdf
> (IBM does hold patent rights to the base algorithm ARC)

Peter, this is a large patch, perhaps you could describe what configs 
benefit, how much, and what the right to use status of the patent might 
be. In other words, why would a reader of LKML put in this patch and try it?

The description of how it works is clear, but the problem solved isn't.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
