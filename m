Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUIVLwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUIVLwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUIVLwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:52:13 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:36622 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S264726AbUIVLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:52:07 -0400
Message-ID: <41516764.8030205@superbug.co.uk>
Date: Wed, 22 Sep 2004 12:52:04 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
References: <1095721742.5886.128.camel@bach>  <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de> <1095803902.1942.211.camel@bach> <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 22 Sep 2004, Rusty Russell wrote:
> 
> 
>>On Tue, 2004-09-21 at 22:36, Marc Ballarin wrote:
>>
>>>On Tue, 21 Sep 2004 09:09:02 +1000
>>>"Rusty Russell (IBM)" <rusty@au1.ibm.com> wrote:
>>>
>>>
>>>>Name: Warn that ipchains and ipfwadm are going away
>>>>Status: Trivial
>>>>Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>>>
> What replaces the firewall stuff? It can't just "go away"!
> 
> Cheers,
> Dick Johnson

ipchains and ipfwadm are very old firewall implementations.
The current linux firewall code is called "iptables" and that has been 
present for a long time time, and that is staying.

So, the linux kernel still has firewall features, even with ipchains and 
ipfwadm removed.

James

