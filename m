Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVCKTVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVCKTVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVCKTVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:21:14 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:7568 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261380AbVCKTRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:17:38 -0500
Message-ID: <4231F019.5080006@tmr.com>
Date: Fri, 11 Mar 2005 14:23:05 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.2
References: <20050309083923.GA20461@kroah.com> <200503100754.14711.gene.heskett@verizon.net>
In-Reply-To: <200503100754.14711.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

> Somewhat Greg, it caught me out.  OTOH, once we know that .2 needs .1, 
> we'll be ok.  And it does give a quick method for us frogs to define 
> if one of them is a regression.  The only thing that should break if 
> we leave one out of the squence is the EXTRAVERSION path in the 
> Makefile & we can certainly fix that easily enough for testing.

2nd that, I'm so delighted to have -stable that I will happily accept 
patches of what ever type you find easiest to produce, in this case 
sequential incrementals. Just don't screw the process by changing it, we 
can cope! Anyone who can't figure out how to generate the single big 
diff against mainline shouldn't be patching kernels ;-)
> 
> Question?  Is it a given that these, if they don't have warts, will be 
> in mainline 2.6.12?

I think Linus noted his intention to grab the fixes he likes. That's not 
a determanent process by any means ;-)


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
