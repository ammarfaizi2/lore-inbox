Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWEEOL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWEEOL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWEEOL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:11:26 -0400
Received: from terminus.zytor.com ([192.83.249.54]:59801 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751553AbWEEOL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:11:26 -0400
Message-ID: <445B5C92.5070401@zytor.com>
Date: Fri, 05 May 2006 07:09:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       Riley@Williams.Name, tony.luck@intel.com, johninsd@san.rr.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <445B5524.2090001@gmail.com>
In-Reply-To: <445B5524.2090001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> 
>> Revert "x86_64/i386: increase command line size" patch
>> It's a bootup dependancy, you can't just increase it
>> randomly, and it breaks booting with LILO.
>> Pointed out by Janos Farkas and Adrian Bunk.
> 

Can we get the details, please, instead of a repeat of the same patch, 
so we can figure out a proper solution?

	-hpa
