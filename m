Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUHPWjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUHPWjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUHPWjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:39:46 -0400
Received: from mail.tmr.com ([216.238.38.203]:60428 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267986AbUHPWjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:39:36 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Date: Mon, 16 Aug 2004 18:39:45 -0400
Organization: TMR Associates, Inc
Message-ID: <cfrcnp$9bd$2@gatekeeper.tmr.com>
References: <20040814115548.A19527@infradead.org><Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092695609 9581 192.168.12.100 (16 Aug 2004 22:33:29 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 14 Aug 2004, Christoph Hellwig wrote:
> 
>>Cane we make this 2.6.9 to avoid breaking all kinds of scripts expecting
>>three-digit kernel versions?
> 
> 
> Well, we've been discussing the 2.6.x.y format for a while, so I see this 
> as an opportunity to actually do it... Will it break automated scripts? 
> Maybe. But on the other hand, we'll never even find out unless we try it 
> some time.

So will we see 2.6.8.1-bk1 tomorrow, or 2.6.8-bk1.1, or ??? And what 
will 2.6.8.3 patch against, 2.6.8.2 or 2.6.8?

I think you are perhaps over-solving the problem that an early -bk1 
could have solved without breaking scripts and kernel macros.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
