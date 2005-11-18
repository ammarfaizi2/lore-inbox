Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbVKRSfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVKRSfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbVKRSfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:35:42 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:5571 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1161074AbVKRSfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:35:41 -0500
Message-ID: <437E1F81.4020501@tmr.com>
Date: Fri, 18 Nov 2005 13:37:53 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58YAt-3Fs-5@gated-at.bofh.it> <59ecB-15H-13@gated-at.bofh.it> <59htx-69E-13@gated-at.bofh.it> <5acUX-PU-31@gated-at.bofh.it> <E1Ed5wP-0000cs-VL@be1.lrz>
In-Reply-To: <E1Ed5wP-0000cs-VL@be1.lrz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

> BTW: What about creating a "Native linux support" logo saying "If you find
> a slot and plug it in, you can use it with a vanilla kernel on any arch and
> get vendor support"? That would help against Netgear's faksimile products of
> working models or ATI's claims for having "linux support".

We can do that. Well, Linus can do that... he holds the trademark, he 
could create a "Linux native driver" emblem. Have to be a tad careful to 
require open source to get it, but I don't know about requiring GPL. In 
the real world a single FOSS driver which could be used for Linux, BSD, 
and Solaris would be easier for a vendor to justify, but it would have 
to be covered by a license which satisfied all applications.

Even if it couldn't be part of a kernel.org source, at least if it were 
available in source it would satisfy better than ndis. Anyone with real 
expertise in what license could apply to all kernels please speak up.

None of this should imply that I have changed my mind about larger stack 
sizes being desirable.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
