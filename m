Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUGSUZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUGSUZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 16:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUGSUZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 16:25:19 -0400
Received: from mail.tmr.com ([216.238.38.203]:55306 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265398AbUGSUZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 16:25:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Date: Mon, 19 Jul 2004 16:27:49 -0400
Organization: TMR Associates, Inc
Message-ID: <cdhade$6bl$2@gatekeeper.tmr.com>
References: <1089857602.15336.4120.camel@abyss.home><1089857602.15336.4120.camel@abyss.home> <20040715023300.GJ3411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090268398 6517 192.168.12.100 (19 Jul 2004 20:19:58 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040715023300.GJ3411@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> There is no technical (or even practical) obstacle to implementing
> in-core page relocation, only a social one: kernel politics. I would not
> be surprised if hotplug memory patches already had code usable for this.

Hopefully that will not prevent them from being put in the kernel :-(

Question: if I create a ramdisk and put a swapfile on that, is it enough 
  to solve the problem, or does the swap have to be on real disk?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
