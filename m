Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVCAUdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVCAUdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCAUcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:32:41 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:3469 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262055AbVCAUav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:30:51 -0500
Message-ID: <4224D0F5.4050400@candelatech.com>
Date: Tue, 01 Mar 2005 12:30:45 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-os@analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network speed Linux-2.6.10
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>	 <4224CE98.2060204@candelatech.com> <1109708691.14272.8.camel@mindpipe>
In-Reply-To: <1109708691.14272.8.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-03-01 at 12:20 -0800, Ben Greear wrote:
> 
>>What happens if you just don't muck with the NIC and let it auto-negotiate
>>on it's own?
> 
> 
> This can be asking for trouble too (auto negotiation is often buggy).
> What if you hard set them both to 100/full?

I have not noticed any buggy autonegotiation with the e100 driver in several
years...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

