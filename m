Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUBYTgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUBYTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:36:46 -0500
Received: from smtp-2.vancouver.ipapp.com ([216.152.192.208]:56332 "EHLO
	axion.net") by vger.kernel.org with ESMTP id S261258AbUBYTgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:36:45 -0500
Message-ID: <403CF94B.5030604@axion.net>
Date: Wed, 25 Feb 2004 11:36:43 -0800
From: Patrick Richard <patr@axion.net>
User-Agent: Mozilla Thunderbird 0.5 (Macintosh/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: e1000 only works in 2.6.3 with UP kernel ?
References: <403CE4E4.9010608@axion.net> <1077733813.8283.1287.camel@tux.rsn.bth.se>
In-Reply-To: <1077733813.8283.1287.camel@tux.rsn.bth.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Country: CA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:

> 
> This is a known problem with 2.6.3
> Please try the latest 2.6.3-bk snapshot, the patch that introduced this
> problem has been reverted.
> 

Thanks,

I have just tried bk-7 in SMP with APIC and ACPI enabled and it didn't 
hang on ifconfig... now testing.

-Pat
