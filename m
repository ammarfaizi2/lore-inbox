Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVIBNxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVIBNxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVIBNxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:53:46 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27908 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751331AbVIBNxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:53:45 -0400
Message-ID: <43185ACF.5060401@tmr.com>
Date: Fri, 02 Sep 2005 09:59:43 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 git snapshot patches still empty
References: <4317A8B7.508@blueyonder.co.uk> <20050901225956.185572ae.akpm@osdl.org>
In-Reply-To: <20050901225956.185572ae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Sid Boyce <sboyce@blueyonder.co.uk> wrote:
> 
>>For both -git1.gz/.bz2 and -git2.gz/.bz2.
> 
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/linus.patch.gz is updated
> once or twice daily.  It's Linus's latest tip-of-tree.

That's nice, but consider trying to find bugs when someone reports a 
problem and there's no ggod way to tell exactly what patches are 
present. At least with git patches, anyone can **easily** replicate the 
source tree for debugging.

Is it really that hard to fix the process?
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
