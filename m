Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268636AbUHLRwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268636AbUHLRwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUHLRwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:52:55 -0400
Received: from mail.tmr.com ([216.238.38.203]:55057 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268636AbUHLRwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:52:53 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.xSMP and IPv4 issues
Date: Thu, 12 Aug 2004 13:56:33 -0400
Organization: TMR Associates, Inc
Message-ID: <cfgaec$fil$1@gatekeeper.tmr.com>
References: <07C92DE0.0827324A.345005B1@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092332812 15957 192.168.12.100 (12 Aug 2004 17:46:52 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <07C92DE0.0827324A.345005B1@netscape.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice wrote:
> Note: I've posted this to the linux-smp list, also... Forgive the newbie in me.
> 
> 
> I'm unable to get IPv4 running correctly when using a 2.6.xSMP kernel,
> but the "same" 2.6.x non-SMP kernel will allown IPv4 to function.
> 
> I have tried a short list of the basics and searched google for help, I
> also posted to my local LUG and tried a few additional things.
> 
> The hardware this is happening on is;
> 
> motherboard: ECS (elitegroup) D6VAA
> NIC: netgear FA311
> DHCP server: Coyote Linux, has run for about two years.

I would consider the NIC driver first... I have no issues with my 
machines, including e100 and e1000 configs on dual Xeon with HT enabled 
and the sk98lin driver on a single CPU with HT and SMP kernel.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
