Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbUCPFTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUCPFTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:19:42 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:17093 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262734AbUCPFTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:19:41 -0500
Message-ID: <40568E49.40503@matchmail.com>
Date: Mon, 15 Mar 2004 21:19:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does "ALI M15x3 chipset support" in drivers/ide support SATA
 PCI cards?
References: <40567B80.5090009@matchmail.com> <405680AB.4020709@pobox.com>
In-Reply-To: <405680AB.4020709@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Mike Fedyk wrote:
> 
>> Hi,
>>
>> I'm looking at non-SIL3112 based SATA PCI cards, and came across some 
>> ALI M1583 based SATA controllers.
>>
>> Should I have a smooth ride with these cards in Linux?
> 
> 
> 
> I haven't seen support for ALi SATA in the IDE driver nor libata...

Thanks Jeff,

I'll stick with the Promise and High Point based cards I saw instead.

Mike
