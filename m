Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSFHU3t>; Sat, 8 Jun 2002 16:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSFHU3q>; Sat, 8 Jun 2002 16:29:46 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:20430 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317447AbSFHU3j>;
	Sat, 8 Jun 2002 16:29:39 -0400
Message-ID: <3D00518D.6040601@candelatech.com>
Date: Thu, 06 Jun 2002 23:24:13 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: ET Sales <sales@etinc.com>
CC: nick@snowman.net, Benjamin LaHaise <bcrl@redhat.com>,
        linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Loosing packets with Dlink DFE-580TX and SMC 9462TX
In-Reply-To: <vewutgw4n1.fsf@inigo.ingate.se> <5.1.0.14.0.20020606091713.021f0730@mail.etinc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't the DFE-580tx a 4-port 10/100bt NIC?  If so, why the
talk about Gigabit speed?

ET Sales wrote:

> At 07:56 PM 6/3/02 -0400, you wrote:
> 
> Uh..aren't those 32-bit cards? There isn't enough bus bandwidth on a 
> 32bit PCI bus to do gigabit, so its more likely that the cards are 
> overrunning their buffers....
> 
> Dennis


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


