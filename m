Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVD1L2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVD1L2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVD1L2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:28:49 -0400
Received: from filip.math.uni.lodz.pl ([212.191.65.243]:37390 "EHLO
	filip.math.uni.lodz.pl") by vger.kernel.org with ESMTP
	id S262049AbVD1L2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:28:48 -0400
Message-ID: <4270C8ED.1080107@filip.math.uni.lodz.pl>
Date: Thu, 28 Apr 2005 13:28:45 +0200
From: Filip Zyzniewski <lkml@filip.math.uni.lodz.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050420)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Panic on a BIOSless machine.
References: <426FB641.2070802@filip.math.uni.lodz.pl>	 <Pine.LNX.4.61.0504271022460.26410@montezuma.fsmlabs.com>	 <4270BF52.7070807@filip.math.uni.lodz.pl> <21d7e99705042804245015a6b1@mail.gmail.com>
In-Reply-To: <21d7e99705042804245015a6b1@mail.gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

>>Here it is:
>>http://filip.math.uni.lodz.pl/t1000-panic/panic-without-tulip.log
>>
>>Do you think memory map is wrong?
> 
> 
> have you the kernel compiled with pci probing set to direct? or booted
> with pci=nobios
> 
> Dave.
> 
> 

I've set pci to direct because the box has no bios. Can I set it to
something else if box has no bios?


bye
Filip Zyzniewski
Ekatalog
