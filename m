Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVFGRxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVFGRxC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 13:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVFGRxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 13:53:02 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28433 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261943AbVFGRw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 13:52:57 -0400
Message-ID: <42A5DF68.6040700@tmr.com>
Date: Tue, 07 Jun 2005 13:54:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stable 2.6.x.y kernel series...
References: <4bt9p-2OQ-3@gated-at.bofh.it> <4cud6-5gm-17@gated-at.bofh.it> <20050607082640.D72153FF9A@irishsea.home.craig-wood.com> <42A5BA66.8040504@tuxrocks.com>
In-Reply-To: <42A5BA66.8040504@tuxrocks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Nick Craig-Wood wrote:
> 
>>Hearty agreement from me.
>>
>>The next hurdle for 2.6.11-stable is to make sure that everything that
>>went into it goes into 2.6.12.  Is there a procedure for that?
> 
> 
> Other way around.  In order to be accepted into -stable, it needs to
> already have been accepted into mainline.  More information at
> http://kerneltrap.org/node/4827/54751

It's more complex than that, because -stable allows simple fixes while a 
complex fix or even total rethink may be in mainline. I'm personally 
happy with that, although I don't know if it has actually happened.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
