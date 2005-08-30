Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVH3KSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVH3KSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVH3KSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:18:06 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:38950 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750935AbVH3KSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:18:05 -0400
Message-ID: <43143258.5080208@gentoo.org>
Date: Tue, 30 Aug 2005 11:18:00 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Kieu <haiquy@yahoo.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
References: <20050830095837.27383.qmail@web53607.mail.yahoo.com>
In-Reply-To: <20050830095837.27383.qmail@web53607.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Kieu wrote:
>>Are you using skge or sk98lin?
> 
> 
> sk98lin
> 
> thanks

Can you test the new skge driver instead? If that one is broken then we 
probably have more chance of getting it fixed :)

Thanks,
Daniel
