Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUB2R6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 12:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbUB2R6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 12:58:22 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:17540 "EHLO
	rhenium.btinternet.com") by vger.kernel.org with ESMTP
	id S262089AbUB2R6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 12:58:21 -0500
Message-ID: <40422850.9010308@btopenworld.com>
Date: Sun, 29 Feb 2004 17:58:40 +0000
From: Subodh Shrivastava <subodh@btopenworld.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sbp2 module not initialising external hdd connected on firewire
 port.
References: <40409D0A.8040903@btopenworld.com> <20040229143756.GB1078@phunnypharm.org>
In-Reply-To: <20040229143756.GB1078@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:

>On Sat, Feb 28, 2004 at 01:52:10PM +0000, Subodh Shrivastava wrote:
>  
>
>>Hi Ben,
>>
>>I am trying to connect my external HDD on firewire port. Linux is not 
>>recognising this disk. Same disk is recognised in windows, also its 
>>recognised in linux when connected on USB port. Attached here is my 
>>.config file, lspci output, dmesg output.
>>    
>>
>
>Can you try the latest code from our repo at linux1394.org? Or atleast
>try this patch applied to 2.6.4-rc1.
>  
>
Provided patch resolves the problem.

Many thanks
Subodh Shrivastava

