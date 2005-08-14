Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVHNVJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVHNVJb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 17:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHNVJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 17:09:31 -0400
Received: from adsl-64-217-116-74.dsl.hstntx.swbell.net ([64.217.116.74]:40455
	"EHLO dsl-64-217-116-74.dsl.hstntx.swbell.net") by vger.kernel.org
	with ESMTP id S932301AbVHNVJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 17:09:31 -0400
Message-ID: <42FFB309.9020106@adsl-64-217-116-74.dsl.hstntx.swbell.net>
Date: Sun, 14 Aug 2005 21:09:29 +0000
From: James Tabor <jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IT8212/ITE RAID
References: <20050814053017.GA27824@zip.com.au> <42FF263A.8080009@gentoo.org>
In-Reply-To: <42FF263A.8080009@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> CaT wrote:
> 
>> 1. Alan Cox's IDE driver that was included in his ac patchset, which
>>    seems to have died at 2.6.11ac7.
>> 2. A brief visit from a SCSI IDE driver in Andrew Mortons mm patchset.
>>    It lived a brief but noted life before being taken out without any
>>    reason (that I spotted) in 2.6.12-rc4-mm1
> 
> 
> Alan's driver has been merged into 2.6.13. You can get the up-to-date 
> patches here:
> 
> http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/2315_ide-no-lba.patch
> http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/4345_it8212.patch
> 
> Daniel
Hi All!
So far I'm having good luck with Alans patch, 2.6.11ac7. I have all the
ports used and it boots and writes Cd's too.

Thanks Alan,
James
