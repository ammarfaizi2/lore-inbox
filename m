Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbUKJVUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUKJVUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUKJVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:20:32 -0500
Received: from mail.tmr.com ([216.238.38.203]:59147 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262041AbUKJVUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:20:18 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [2.6 patch] Use -ffreestanding?
Date: Wed, 10 Nov 2004 16:01:26 -0500
Organization: TMR Associates, Inc
Message-ID: <419281A6.5030106@tmr.com>
References: <20041110014516.GC4089@stusta.de><20041108134448.GA2456@wotan.suse.de> <Pine.LNX.4.58.0411091750480.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1100121102 19868 192.168.12.100 (10 Nov 2004 21:11:42 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0411091750480.2301@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 10 Nov 2004, Adrian Bunk wrote:
> 
>>I'm open for examples why this actually doesn't work, but after my 
>>(limited) testin I'd suggest the patch below for inclusion in the next 
>>-mm.
> 
> 
> When was -ffreestanding introduced? Iow, it might not work with all 
> compiler versions.. Apart from that, I think it makes sense. 

 From RH 7.3:
   gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
